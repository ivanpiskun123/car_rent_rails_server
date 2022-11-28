# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :encrypted_password, String, null: false
    field :jti, String, null: false
    field :reset_password_token, String
    field :first_name, String, null: false
    field :second_name, String, null: false
    field :phone, String, null: false
    field :locked, Boolean, null: false
    field :locked_at, GraphQL::Types::ISO8601DateTime
    field :created_at, GraphQL::Types::ISO8601Date, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :role_id, Integer
    field :role, Types::RoleType

    def created_at
      object.created_at.to_date
    end


  end
end
