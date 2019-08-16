# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tester_group = [
  { username: "tester1",
    email: "1@test.com",
    password: "test"
  },
  { username: "tester2",
    email: "2@test.com",
    password: "test"
  },
  { username: "tester3",
    email: "3@test.com",
    password: "test"
  },
  { username: "tester4",
    email: "4@test.com",
    password: "test"
  },
  { username: "tester5",
    email: "5@test.com",
    password: "test"
  },
  { username: "tester6",
    email: "6@test.com",
    password: "test"
  },
  { username: "tester7",
    email: "7@test.com",
    password: "test"
  },
  { username: "tester8",
    email: "8@test.com",
    password: "test"
  },
  { username: "tester9",
    email: "9@test.com",
    password: "test"
  },
  { username: "tester10",
    email: "10@test.com",
    password: "test"
  },
  { username: "tester11",
    email: "11@test.com",
    password: "test"
  },
  { username: "tester12",
    email: "12@test.com",
    password: "test"
  },
  { username: "tester13",
    email: "13@test.com",
    password: "test"
  },
  { username: "tester14",
    email: "14@test.com",
    password: "test"
  },
  { username: "tester15",
    email: "15@test.com",
    password: "test"
  },
  { username: "tester16",
    email: "16@test.com",
    password: "test"
  },
  { username: "tester17",
    email: "17@test.com",
    password: "test"
  },
  { username: "tester18",
    email: "18@test.com",
    password: "test"
  },
  { username: "tester19",
    email: "19@test.com",
    password: "test"
  },
  { username: "tester20",
    email: "20@test.com",
    password: "test"
  }
]

testers = User.create(tester_group)

testers.each do |tester|
  product = tester.products.build(
    name: "#{tester.username}'s Product",
    description: "A good description for a test product",
    git_repo: "www.github.com/#{tester.id}",
    website: "www.#{tester.name}.com",
    status: "New"
  )
  product.save
end

products = Product.all

products.each do |product|
  version = product.versions.build(
    version_number: "v1",
    description: "First commit",
    release_date: "January 1 2020",
    planned_budget: "5000"
  )
  version.user = product.user
  product.versions << version
  version.save
end

versions = Version.all

tasks = [
  {
    name: "A first task",
    description: "It must be completed as soon as possible",
    reward: 50,
    status: "Open"
  },
  {
    name: "A second task",
    description: "It must be completed as soon as possible",
    reward: 60,
    status: "Open"
  },
  {
    name: "A third task",
    description: "It must be completed as soon as possible",
    reward: 75,
    status: "Open"
  },
  {
    name: "A fourth task",
    description: "It must be completed as soon as possible",
    reward: 100,
    status: "Open"
  },
  {
    name: "A fifth task",
    description: "It must be completed as soon as possible",
    reward: 120,
    status: "Open"
  },
  {
    name: "A sixth task",
    description: "It must be completed as soon as possible",
    reward: 180,
    status: "Open"
  },
  {
    name: "A seventh task",
    description: "It must be completed as soon as possible",
    reward: 250,
    status: "Open"
  },
  {
    name: "An eighth task",
    description: "It must be completed as soon as possible",
    reward: 300,
    status: "Open"
  },
  {
    name: "A ninth task",
    description: "It must be completed as soon as possible",
    reward: 320,
    status: "Open"
  },
  {
    name: "A tenth task",
    description: "It must be completed as soon as possible",
    reward: 250,
    status: "Open"
  },
  {
    name: "An eleventh task",
    description: "It must be completed as soon as possible",
    reward: 50,
    status: "Open"
  },
  {
    name: "A twelfth task",
    description: "It must be completed as soon as possible",
    reward: 60,
    status: "Open"
  },
  {
    name: "A thirteenth task",
    description: "It must be completed as soon as possible",
    reward: 75,
    status: "Open"
  },
  {
    name: "A fourteenth task",
    description: "It must be completed as soon as possible",
    reward: 100,
    status: "Open"
  },
  {
    name: "A fifteenth task",
    description: "It must be completed as soon as possible",
    reward: 120,
    status: "Open"
  },
  {
    name: "A sixteenth task",
    description: "It must be completed as soon as possible",
    reward: 180,
    status: "Open"
  },
  {
    name: "A seventeenth task",
    description: "It must be completed as soon as possible",
    reward: 250,
    status: "Open"
  },
  {
    name: "An eighteenth task",
    description: "It must be completed as soon as possible",
    reward: 300,
    status: "Open"
  },
  {
    name: "A ninteenth task",
    description: "It must be completed as soon as possible",
    reward: 320,
    status: "Open"
  },
  {
    name: "A twentieth task",
    description: "It must be completed as soon as possible",
    reward: 250,
    status: "Open"
  }
]

versions.each do |version|
  tasks.each do |task|
    built_task = version.tasks.build(task)
    built_task.product = version.product
    version.tasks << built_task
    built_task.save
  end
end
