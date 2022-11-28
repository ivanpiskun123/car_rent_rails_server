# frozen_string_literal: true

class Api::V1::Users::RegistrationsController < Devise::SessionsController

  respond_to :json
  skip_before_action :authenticate_user!

  def create
    u = User.create!(
      {
        role_id: 1,
        email: params["user"]["email"],
        password: params["user"]["password"],
        password_confirmation: params["user"]["password"],
        first_name: params["user"]["first_name"],
        second_name: params["user"]["second_name"],
        phone: params["user"]["phone"]
      }
    )
    Image.create!(
      {
        reference_type: "User",
        reference_id: u.id,
        image_url: params["user"]["image"]
      }
    )
    token = u.generate_jwt
    render json:
             {
               token:  token.to_json,
               user_id: u.id,
               is_admin: u.role.id == 2,
               locked: u.locked
             }
  end

end
