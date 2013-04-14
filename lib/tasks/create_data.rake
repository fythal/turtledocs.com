namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    # me = User.create!(
    # # first_name: "Randy",
    # # last_name: "Stewart",
    # # address: "3094 S. Mountain Ledge Cir.",
    # # city: "Saint George",
    # # state: "Ut",
    # # zip: "84790",
    # # phone: "(435) 680-1097",
    # email: "randysteswart8@gmail.com",
    # password: "password",
    # password_confirmation: "password",
    # name: "randys"
    # # status: "active"
    # )
    # me.add_role :admin
    
  
  # admin = User.create!(
  #   first_name: "example",
  #   last_name: "User",
  #   address: Faker::Address.street_address,
  #   city: Faker::Address.city,
  #   state: Faker::Address.state,
  #   zip: Faker::Address.zip_code,
  #   phone: Faker::PhoneNumber.phone_number,
  #   email: "example@railstutorial.org",
  #   password: "foobar",
  #   password_confirmation: "foobar",
  #   status: "active")
    
  
    99.times do |n|
      email = Faker::Internet.email
      password = "boguspassword"
      name = Faker::Name.first_name.downcase
      # first_name = Faker::Name.first_name
      # last_name = Faker::Name.last_name
      # address = Faker::Address.street_address
      # city = Faker::Address.city
      # state = Faker::Address.state
      # zip = Faker::Address.zip_code
      # phone = Faker::PhoneNumber.phone_number
      bogus = User.create!(
        email: email,
        password: password,
        password_confirmation: password,
        name: name
        # first_name: first_name,
        # last_name: last_name,
        # address: address,
        # city: city,
        # state: state,
        # zip: zip,
        # phone: phone,
        # status: status
        )
      rand = rand(1..10)
      if rand > 0 && rand < 3
        bogus.add_role :manager
      elsif  rand > 2 && rand <8
        bogus.add_role :user
      else
        bogus.add_role :guest
      end
      
    end
    
    equipments = ['Trane', 'Amana', 'Bryant', 'American Standard', 'Carrier']
    equipments.each do |e|
      eq = Equipment.create!(name: e)
    end

  end
end