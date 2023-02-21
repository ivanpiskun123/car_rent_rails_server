class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_user!

  def index
      render json: {
        data: UserSerializer.new(User.joins("join roles r on users.role_id=r.id").where("r.id=1").all).serializable_hash
      }, status: :ok
  end

  def show
    render json: {
      data: UserSerializer.new(User.find(params["id"])).serializable_hash
    }, status: :ok
  end

  def short_show
    render json: {
      data: UserShortSerializer.new(User.find(params["id"])).serializable_hash
    }, status: :ok
  end

  def approve_doc
    User.find(params["id"]).document.update(status: 2)
    render json: {
      data: "Approved"
    }, status: :ok
  end

  def reject_doc
    User.find(params["id"]).document.update(status: 0)
    render json: {
      data: "Reject"
    }, status: :ok
  end


end
