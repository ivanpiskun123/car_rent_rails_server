class Api::V1::CarsController < ApplicationController
  skip_before_action :authenticate_user!

  def index

    if params["renting"].present?
      cars = Car.where(ready_to_rent: true).all.filter {|c|  not c.car_rents.exists?(is_paid: [nil, false])  }
      render json: {
        data: CarSerializer.new(cars).serializable_hash
      }, status: :ok
    else
      render json: {
        data: CarSerializer.new(Car.all).serializable_hash
      }, status: :ok
    end
  end

  def show
    render json: {
      data: CarSerializer.new(Car.find(params["id"])).serializable_hash
    }, status: :ok
  end

  def to_repair
    c = Car.find(params["id"])
    c.update(ready_to_rent: false)
    render json: {
      data: CarSerializer.new(c).serializable_hash
    }, status: :ok
  end

  def to_rent
    c = Car.find(params["id"])
    c.update(ready_to_rent: true)
    render json: {
      data: CarSerializer.new(c).serializable_hash
    }, status: :ok
  end


  def create

    sum_points = params["bid"]["sum_points"].to_i

    p = PremiumForScore.all.map do |ps|
      [ps.id, sum_points - ps.score]
    end
    p = p.filter{|y| y[1]>=0 }
    p1 = p.map{|t| t[1]}.min
    ps_id = p.find{|y| y[1] == p1 }.first

    b = Bid.new(worker_id: params["bid"]["worker_id"],
                user_id: params["bid"]["user_id"],
                premium_for_score_id: ps_id
                )

    if b.save!
      render json: {
        data: BidSerializer.new(b).serializable_hash
      }, status: :ok
    else
      render json: {status: "error", code: 400,
                    client_message: "Please check if typed data is correct",
                    error_message: b.errors}
    end

  end

  def reject
    b = Bid.find(params["id"])
    b.reject!
    render json: {
      data: BidSerializer.new(b).serializable_hash
    }, status: :ok
  end

  def apply
    b = Bid.find(params["id"])
    pa = PremiumFund.last.fund_amount
    PremiumFund.last.update(fund_amount: pa-b.premium_for_score.amount)
    b.apply!
    render json: {
      data: BidSerializer.new(b).serializable_hash
    }, status: :ok
  end

end
