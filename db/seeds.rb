# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create Users if not exits
if User.find_by(email: 'teacher1@email.com')==nil
  u = User.create({
    email: 'teacher1@email.com',
    username: 'First Teacher',
    role: 'TCH',
    password: 't11111',
    password_confirmation: 't11111'
    })
  t = Teacher.create({
    user_id: u.id,
    nationality: 'USA',
    price: '100',
    experience: '4 years',
    linkedin: ''
    })
end

if User.find_by(email: 'teacher2@email.com')==nil
  u = User.create({
    email: 'teacher2@email.com',
    username: 'Second Teacher',
    role: 'TCH',
    password: 't22222',
    password_confirmation: 't22222'
    })
  t = Teacher.create({
    user_id: u.id,
    nationality: 'Vietnam',
    price: '75',
    experience: '3 years',
    linkedin: ''
    })
end

if User.find_by(email: 'teacher3@email.com')==nil
  u = User.create({
    email: 'teacher3@email.com',
    username: 'Third Teacher',
    role: 'TCH',
    password: 't33333',
    password_confirmation: 't33333'
    })
  t = Teacher.create({
    user_id: u.id,
    nationality: 'Vietnam',
    price: '50',
    experience: '2 years',
    linkedin: ''
    })
end
