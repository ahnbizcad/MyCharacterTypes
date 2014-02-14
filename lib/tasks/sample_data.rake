namespace :db do

  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(username: "exuser",
                 email: "e@G.C",
                 password: "foobar",
                 password_confirmation: "foobar")
    99.times do |n|
      username  = Faker::Name.name
      email = "example-#{n+1}@g.c"
      password  = "foobar"
      User.create!(username:              username,
                   email:                 email,
                   password:              password,
                   password_confirmation: password)
    end
  end

end