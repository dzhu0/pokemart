puts 'Adding Admin user.'

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

puts 'Admin user added.'
