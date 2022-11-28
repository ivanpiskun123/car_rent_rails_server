# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

bs = []
10.times do
  loop do
    b = Faker::Vehicle.make
    if bs.exclude?(b)
      bs << b
      break
    end
  end

  CarBrand.create!(name: bs.last)
end

puts "Brands created"

bs = []
6.times do
  loop do
    b = Faker::Vehicle.fuel_type
    if bs.exclude?(b) and b.downcase !="Compressed Natural Gas".downcase
      bs << b
      break
    end
  end


  FuelType.create!(name: bs.last)
end

puts "Fuels created"

Role.create!(name: "Пользователь")
Role.create!(name: "Администратор")

(1..5).each do |i|
  User.create!(
    {
      role_id: 1,
      phone: Faker::PhoneNumber.cell_phone_in_e164,
      first_name: Faker::Name.first_name,
      second_name: Faker::Name.last_name,
      email: "user#{i}@gmail.com",
      password: "admin123",
      password_confirmation: "admin123",
      jti: SecureRandom.uuid
    }
  )
end

user_docs_imgs = [
  %w[https://res.cloudinary.com/drntpsmxs/image/upload/v1669139918/graduates/car_rent/users/vesszcwchv7l7drjfuyi.jpg https://res.cloudinary.com/drntpsmxs/image/upload/v1669139894/graduates/car_rent/docs/ltcveczvcqcvd4cph1bq.jpg],
  %w[https://res.cloudinary.com/drntpsmxs/image/upload/v1669139918/graduates/car_rent/users/z1zmowhencxgfzcfik6w.jpg https://res.cloudinary.com/drntpsmxs/image/upload/v1669139894/graduates/car_rent/docs/d43vtji3xsgfvljeczm6.jpg],
  %w[https://res.cloudinary.com/drntpsmxs/image/upload/v1669139917/graduates/car_rent/users/fhqdchupxe41gxzwdjrn.jpg https://res.cloudinary.com/drntpsmxs/image/upload/v1669139894/graduates/car_rent/docs/tzvreunvvzxc4priprao.jpg],
  %w[https://res.cloudinary.com/drntpsmxs/image/upload/v1669139917/graduates/car_rent/users/dhskgnxgoeg75farbykb.jpg https://res.cloudinary.com/drntpsmxs/image/upload/v1669139894/graduates/car_rent/docs/ptsrxoszrnyiqvyrc0pl.jpg],
  %w[https://res.cloudinary.com/drntpsmxs/image/upload/v1669139917/graduates/car_rent/users/hbk2mbuzzgj51paskrp2.jpg https://res.cloudinary.com/drntpsmxs/image/upload/v1669139894/graduates/car_rent/docs/qbhzv1npxgjgs10kkozs.jpg],
]

(0..3).each do |i|
  Image.create!(
    {
      image_url: user_docs_imgs[i][0],
      reference_id: (i+1),
      reference_type: "User"
    }
  )

  Document.create!(
    {
      status: 2,
      user: User.find(i+1)
    }
  )

  Image.create!(
    {
      image_url: user_docs_imgs[i][1],
      reference_id: (i+1),
      reference_type: "Document"
    }
  )
end

Image.create!(
  {
    image_url: user_docs_imgs[4][0],
    reference_id: (5),
    reference_type: "User"
  }
)

Document.create!(
  {
    status: 1,
    user: User.find(5)
  }
)


User.create!(
  {
    role_id: 2,
    phone: Faker::PhoneNumber.cell_phone_in_e164,
    first_name: Faker::Name.first_name,
    second_name: Faker::Name.last_name,
    email: "admin1@gmail.com",
    password: "admin123",
    password_confirmation: "admin123",
    jti: SecureRandom.uuid
  }
)

User.create!(
  {
    role_id: 2,
    phone: Faker::PhoneNumber.cell_phone_in_e164,
    first_name: Faker::Name.first_name,
    second_name: Faker::Name.last_name,
    email: "admin2@gmail.com",
    password: "admin123",
    password_confirmation: "admin123",
    jti: SecureRandom.uuid
  }
)

User.all.each do |u|
  u.created_at = Time.now - rand(400..1800).minutes
  u.save!
end

10.times do
  c = Car.create!(
    {
      price_per_min: rand(2..7),
      name: Faker::Vehicle.model,
      engine_volume: rand(1.3 .. 4.5).round(1),
      condition: rand(4..10),
      edition_year: rand(1995..2020),
      fuel_type: FuelType.order('RANDOM()').first,
      car_brand: CarBrand.order('RANDOM()').first
    }
  )
  c.created_at =  Time.now - rand(1800..2000).minutes
  c.save!
end

Car.find(4).to_restore!
Car.find(5).to_restore!

cars_img = %w[
https://res.cloudinary.com/drntpsmxs/image/upload/v1669142537/graduates/car_rent/cars/xahc4vt3llscqcelxtal.jpg
https://res.cloudinary.com/drntpsmxs/image/upload/v1669142536/graduates/car_rent/cars/o3qzbsddvv9xjjje5x4w.jpg
https://res.cloudinary.com/drntpsmxs/image/upload/v1669142536/graduates/car_rent/cars/lzcyl1kid90m4lfpw81p.jpg
https://res.cloudinary.com/drntpsmxs/image/upload/v1669142536/graduates/car_rent/cars/wvvepkxdoe7plean0v6y.jpg
https://res.cloudinary.com/drntpsmxs/image/upload/v1669142536/graduates/car_rent/cars/czkhrrublasyos3n9wqk.jpg
https://res.cloudinary.com/drntpsmxs/image/upload/v1669142535/graduates/car_rent/cars/oqzjtpgemkwvaqmv79yn.jpg
https://res.cloudinary.com/drntpsmxs/image/upload/v1669142534/graduates/car_rent/cars/jn9zo8hnjvmdkrguns1c.jpg
https://res.cloudinary.com/drntpsmxs/image/upload/v1669142534/graduates/car_rent/cars/xpmpimta7dem8ns6tfsf.jpg
https://res.cloudinary.com/drntpsmxs/image/upload/v1669142534/graduates/car_rent/cars/xtljnvbdl4fy0tciqbus.jpg
https://res.cloudinary.com/drntpsmxs/image/upload/v1669142534/graduates/car_rent/cars/lv8bu567uxhyzawy4o6s.jpg

]

cars_img.each_with_index do |v, idx|
  Image.create!(
    {
      image_url: v,
      reference_id: (idx+1),
      reference_type: "Car"
    }
  )
end


45.times do
  begin
  cr = CarRent.create!(
    {
      user: User.where(id: [1..5]).order('RANDOM()').first,
      car: Car.order('RANDOM()').first,
      is_paid: [true, false].sample
    }
  )
  rescue ActiveRecord::RecordInvalid
    puts "One CR skipped"
    next
  end

  cr.created_at = Time.now - rand(100..400).minutes

  if cr.is_paid
    cr.ended_at = cr.created_at + rand(10..100).minutes
    cr.save!
    p = Payment.create!(
      {
        is_paid: true,
        amount: cr.car.price_per_min * ((cr.ended_at - cr.created_at)/1.minute.round),
        car_rent: cr
      }
    )
    p.created_at = cr.ended_at
    p.save!
  else
    if [false, true].sample
      if [false, true].sample
      cr.ended_at = Time.now - rand(10..30).minutes
      cr.save!
      p = Payment.create!(
        {
          is_paid: false,
          amount: cr.car.price_per_min * ((cr.ended_at - cr.created_at)/1.minute.round),
          car_rent: cr
        }
      )
      p.created_at = cr.ended_at
      p.save!
      end
    end

  end
end

User.where(id: [1..5]).all.each do |u|

  if u.id != 1
    PaymentCard.create!(
      {
        user: u,
        code: Faker::Finance.credit_card(:mastercard).gsub("-", ""),
        cvv: rand(100 .. 999),
        date_exp: (Time.now + rand(15..45).month).strftime("%m/%y")
      }
    )
  end

end



