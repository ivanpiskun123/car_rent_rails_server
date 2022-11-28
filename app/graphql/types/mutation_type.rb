module Types
  class MutationType < Types::BaseObject

    field :pay_for_payment, mutation: Mutations::PayForPayment
    field :change_or_create_user_doc, mutation: Mutations::ChangeOrCreateUserDoc
    field :change_or_create_payment_card, mutation: Mutations::ChangeOrCreatePaymentCard


  end
end
