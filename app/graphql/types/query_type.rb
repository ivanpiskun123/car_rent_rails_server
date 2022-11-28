module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField



    # field :users, [UserType], null: false, description: 'List of all users'
    # def users
    #   User.all
    # end
    #
    field :payments, [Types::PaymentType], description: 'Get payments of specific user' do
      argument :user_id, ID, required: true
    end
    def payments(user_id:)
      User.find(user_id).payments.order(created_at: :desc)
    end

    field :payment_card, Types::PaymentCardType, description: 'Get payment card of specific user' do
      argument :user_id, ID, required: true
    end
    def payment_card(user_id:)
      PaymentCard.find_by(user_id: user_id)
    end

  end
end
