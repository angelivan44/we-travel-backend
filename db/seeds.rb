# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

p "creando los usuarions"

user = User.create(name: "test", 
email: "test@mail.com", 
password: "123456", 
token: "asdasdasdasdasd", 
username: "test1",
birthdate: "12/01/1999",
description: "A passionate Full-Stack developer from Peru peru",
social: "@test")
user.avatar.attach(io: File.open('app/assets/logo.png'), filename: 'logo.png')
user.cover.attach(io: File.open('app/assets/logo.png'), filename: 'logo.png')

user2 = User.create(name: "test2", 
email: "test2@mail.com", 
password: "123456", 
token: "asdasdasdasdasd", 
username: "test2",
birthdate: "12/01/1999",
description: "A passionate Full-Stack developer from Peru peru",
social: "@test2"
)
user2.avatar.attach(io: File.open('app/assets/logo.png'), filename: 'logo.png')
user2.cover.attach(io: File.open('app/assets/logo.png'), filename: 'logo.png')


user3 = User.create(name: "test3", 
email: "test3@mail.com", 
password: "123456", 
token: "asdasdasdasdasd", 
username: "test3",
birthdate: "12/01/1999",
description: "A passionate Full-Stack developer from Peru peru",
social: "@test3")
user3.avatar.attach(io: File.open('app/assets/logo.png'), filename: 'logo.png')
user3.cover.attach(io: File.open('app/assets/logo.png'), filename: 'logo.png')

user.following.push(user2)

user2.following.push(user3)

user3.following.push(user)

p "creando los departamentos"

huancayo = Department.create(name: "Huancayo", description: "lsaslaklsklasklask")
huancayo.cover.attach(io: File.open('app/assets/logo.png'), filename: 'logo.png')

ica = Department.create(name: "Ica", description: "jejekeleleklelelekl")
ica.cover.attach(io: File.open('app/assets/logo.png'), filename: 'logo.png')

p "creando el post"

post = Post.new(title: "test", body: "asdasdasdasdsadsadsadsa")
post.user = user
post.department = huancayo
post.images.attach(io: File.open('app/assets/logo.png'), filename: 'logo.png')
post.images.attach(io: File.open('app/assets/logo.png'), filename: 'logo.png')
post.images.attach(io: File.open('app/assets/logo.png'), filename: 'logo.png')


post2 = Post.new(title: "test2", body: "jejejaksjdlskadjlskdjklsadjklewe")
post2.user = user2
post2.department = ica
post2.images.attach(io: File.open('app/assets/logo.png'), filename: 'logo.png')
post2.images.attach(io: File.open('app/assets/logo.png'), filename: 'logo.png')
post2.images.attach(io: File.open('app/assets/logo.png'), filename: 'logo.png')

p "creando el commentario"
comment1 = Comment.new(body: "buen dato crack")
comment1.user = user2
comment1.save
post.comments.push(comment1)



comment2 = Comment.new(body: "ggwp")
comment2.user = user
comment2.save

post2.comments.push(comment2)

p "creando el like"
likepost = Like.new
likepost.user = user
likepost.save

post.likes.push(likepost)

likecomment = Like.new
likecomment.user = user2

post2.likes.push(likecomment)

post.save
post2.save