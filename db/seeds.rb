# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create(name: "test", email: "test@mail.com", password: "123456", token: "asdasdasdasdasd", username: "test1")
user.avatar.attach(io: File.open('app/assets/logo.png'), filename: 'logo.png')

user2 = User.create(name: "test2", email: "test2@mail.com", password: "123456", token: "asdasdasdasdasd", username: "test2")
user2.avatar.attach(io: File.open('app/assets/logo.png'), filename: 'logo.png')

user3 = User.create(name: "test3", email: "test3@mail.com", password: "123456", token: "asdasdasdasdasd", username: "test3")
user3.avatar.attach(io: File.open('app/assets/logo.png'), filename: 'logo.png')

user.following.push(user2)

user2.following.push(user3)

user3.following.push(user)

huancayo = Department.create(name: "Huancayo", description: "lsaslaklsklasklask")
ica = Department.create(name: "Ica", description: "jejekeleleklelelekl")

post = Post.new(title: "test", body: "asdasdasdasdsadsadsadsa")
post.user = user
post.department = huancayo
post.images.attach(io: File.open('app/assets/logo.png'), filename: 'logo.png')
post.save

post2 = Post.new(title: "test2", body: "jejejaksjdlskadjlskdjklsadjklewe")
post2.user = user2
post2.department = ica
post2.images.attach(io: File.open('app/assets/logo.png'), filename: 'logo.png')
post2.save

comment1 = Comment.new(body: "buen dato crack")
comment1.user = user2
comment1.post = post
comment1.save


comment2 = Comment.new(body: "ggwp")
comment2.user = user
comment2.post = post2
comment2.save

likepost = Like.new
likepost.user = user
likepost.post = post
like.save

likecomment = Like.new
likecomment.user = user2
likecomment.comment = comment2