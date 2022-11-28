module Mutations
  class PayForPayment < BaseMutation
    argument :payment_id, Int, required: true

    field :payment, Types::PaymentType, null: true
    field :errors, [String], null: false

    def resolve(payment_id:)
      begin
        p = Payment.find(payment_id)
        p.paid!
        { payment: p, errors: [] }
      rescue => error
        { payment: nil, errors: error.message }
      end
    end

  end
end
