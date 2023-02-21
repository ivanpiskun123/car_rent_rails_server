RSpec.describe PaymentCard, type: :model do
  let(:user) { create(:user) }

  it "is valid with valid attributes" do
    payment_card = PaymentCard.new(
      code: "1234567890123456",
      cvv: "123",
      date_exp: "12/25",
      user: user
    )
    expect(payment_card).to be_valid
  end

  it "is not valid without a code" do
    payment_card = PaymentCard.new(
      cvv: "123",
      date_exp: "12/25",
      user: user
    )
    expect(payment_card).not_to be_valid
  end

  it "is not valid without a cvv" do
    payment_card = PaymentCard.new(
      code: "1234567890123456",
      date_exp: "12/25",
      user: user
    )
    expect(payment_card).not_to be_valid
  end

  it "is not valid without a date_exp" do
    payment_card = PaymentCard.new(
      code: "1234567890123456",
      cvv: "123",
      user: user
    )
    expect(payment_card).not_to be_valid
  end

  it "is not valid without a user" do
    payment_card = PaymentCard.new(
      code: "1234567890123456",
      cvv: "123",
      date_exp: "12/25"
    )
    expect(payment_card).not_to be_valid
  end

  it "belongs to a user" do
    payment_card = PaymentCard.new(
      code: "1234567890123456",
      cvv: "123",
      date_exp: "12/25",
      user: user
    )
    expect(payment_card.user).to eq(user)
  end
end
