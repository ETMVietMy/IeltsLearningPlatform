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

# Create Admin and System mailing User
if User.find_by(email: 'etm_admin1@email.com')==nil
  u = User.create({
    email: 'etm_admin1@email.com',
    username: 'First Admin',
    role: 'ADM',
    password: 'admin1',
    password_confirmation: 'admin1'
    })
end

# Create Account
User.all.each do |user|
  if user.account.nil?
    a = Account.create({
      user_id: user.id,
      balance: 0,
      status: "active"
      })
  end
end

# Create transaction_type
if TransactionType.find_by(code: TransactionType::TOPUP)==nil
  TransactionType.create(
    name: 'Top Up Account',
    code: 'TOPUP'
  )
end
if TransactionType.find_by(code: TransactionType::PENDING_PAYMENT)==nil
  TransactionType.create(
    name: 'Pay for correcting',
    code: 'PAYMENT'
  )
end
if TransactionType.find_by(code: TransactionType::SETTLE_PAYMENT)==nil
  TransactionType.create(
    name: 'Settle Payment for correcting',
    code: 'SETTLE_PAYMENT'
  )
end
if TransactionType.find_by(code: TransactionType::A2A)==nil
  TransactionType.create(
    name: 'Account to Account transaction',
    code: 'A2A'
  )
end
if TransactionType.find_by(code: TransactionType::CANCEL)==nil
  TransactionType.create(
    name: 'Cancel Pending Payment',
    code: 'CANCEL'
  )
end

if Task.count == 0
  tasks = ['Some people say that zoos have no useful purpose. Others believe that zoos are beneficial in many ways. Discuss and give your opinion.',
    'While some people think that reading books rather than watching TV is more beneficial for one’s imagination and language acquisition, I content that the role of the former in boosting intelligence and language ability is equal to the latter.',
    'While it is argued that a distinguished career is regarded as the most pivotal thing in a person’s life, I strongly believe that there are other factors which can make people’s lifetime become meaningful.',
    'Parents often give children everything they ask for and do what they like. Is it good for children? What are the consequences when they grow up?'
  ]

  tasks.each do |task|
    Task.create(description: task, task_number: 2)
  end
end
