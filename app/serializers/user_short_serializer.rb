class UserShortSerializer
  include JSONAPI::Serializer

  attribute :doc_status do |candidate|
    candidate.document&.status
  end

  attribute :have_card do |candidate|
    not candidate.payment_card.nil?
  end

  attribute :unpaid_count do |candidate|
    candidate.payments.where(is_paid: false).count
  end

end
