# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

testers = User.create(
  [
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
  ]
)

testers.each do |tester|
  product = tester.products.build(
    name: "#{tester.username}'s Product",
    description: "A good description for a test.",
    git_repo: "www.github.com/#{tester.id}",
    website: "www.#{tester.username}.com",
    status: "New"
  )
  product.save
end

products = Product.last(5)
#
# products.each do |product|
#   product.versions.build(
#     version_number: "v1",
#     description: "First commit",
#
#   )
# end
