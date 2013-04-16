namespace :db do
    desc "Create user randys"
    task Create_Randy: :environment do
        me = User.create!(
        # first_name: "Randy",
        # last_name: "Stewart",
        # address: "3094 S. Mountain Ledge Cir.",
        # city: "Saint George",
        # state: "Ut",
        # zip: "84790",
        # phone: "(435) 680-1097",
        email: "randystewart8@gmail.com",
        password: "password",
        password_confirmation: "password",
        name: "randy"
        # status: "active"
    )
    me.add_role :admin
    me.add_role :user
    end
end
