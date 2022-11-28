# frozen_string_literal: true

module Types
  class PaymentCardType < Types::BaseObject
    field :id, ID, null: false
    field :code, String, null: false
    field :cvv, String, null: false
    field :date_exp, String, null: false
    field :user_id, Integer
    field :user, Types::UserType
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
