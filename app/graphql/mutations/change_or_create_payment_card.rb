module Mutations
  class ChangeOrCreatePaymentCard < BaseMutation
    argument :user_id, Int, required: true
    argument :code, String, required: true
    argument :cvv, String, required: true
    argument :date_exp, String, required: true

    field :payment_card, Types::PaymentCardType, null: true
    field :errors, [String], null: false

    def resolve(user_id:, code:, cvv:, date_exp:)
      begin
        puts "HERE"
        puts user_id
        puts code

        user = User.find(user_id)
        if user_payment_card = user.payment_card
          user_payment_card.update(code: code, cvv: cvv, date_exp: date_exp)
        else
          user_payment_card = PaymentCard.create(
            code: code, cvv: cvv, date_exp: date_exp, user_id: user_id
          )
        end
        { payment_card: user_payment_card, errors: [] }
      rescue => error
        { payment_card: nil, errors: error.message }
      end
    end
  end
end
