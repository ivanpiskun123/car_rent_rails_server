# frozen_string_literal: true

module Types
  class PaymentType < Types::BaseObject
    field :id, ID, null: false
    field :amount, Integer, null: false
    field :is_paid, Boolean, null: false
    field :rented_car_full_name, String, null: false
    field :created_at, String, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def rented_car_full_name
      object.car_rent.car.full_name
    end

    def created_at
      object.created_at.strftime("%H:%M %d-%m-%Y")
    end

  end
end
