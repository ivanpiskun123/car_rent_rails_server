Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'


  namespace :api do
    namespace :v1 do


      devise_for :users, controllers: {
        sessions: 'api/v1/users/sessions'
      }


    end

    namespace :v2 do
      post "/graphql", to: "graphql#execute"
    end


  end
end
