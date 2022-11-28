Rails.application.routes.draw do


  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/api/v2/graphql"
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'


  namespace :api do
    namespace :v1 do
      devise_for :users, controllers: {
        sessions: 'api/v1/users/sessions'
      }
      resources :car_rents, only: [:index, :create] do
        collection do
          get 'end'
        end
      end

      resources :cars, only: [:index, :show] do
        collection do
          get 'to_repair'
          get 'to_rent'
        end
      end

      resources :users, only: [:index, :show] do
        collection do
          get 'short_show'
          get 'approve_doc'
          get 'reject_doc'
        end
      end

    end

    namespace :v2 do
      post "/graphql", to: "graphql#execute"
    end


  end
end
