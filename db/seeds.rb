Article.destroy_all
User.destroy_all

journalist = User.create(email: 'journalist@mail.com', role: 'journalist', password: 'password')
editor = User.create(email: 'editor@mail.com', role: 'editor', password: 'editor')
registered = User.create(email: 'registered@mail.com', role: 'registered', password: 'editor')
subscriber = User.create(email: 'subscriber@mail.com', role: 'subscriber', password: 'editor')

premium_article = Article.create(
  title: 'U cant imagine what this monkey did in the grocery store',
  lead: 'Omg u need to read this lol',
  content: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.' * 10,
  category: 'lifestyle',
  published: true,
  premium: true,
  location: 'Sweden',
  journalist_id: journalist.id
)
file = URI.open('https://i.ytimg.com/vi/M3zRXaGEQEA/hqdefault.jpg')
premium_article.image.attach(io: file, filename: 'monkey.jpg')

free_article = Article.create(
  title: 'World is burning',
  lead: 'as usual',
  content: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.' * 10,
  category: 'international',
  published: true,
  premium: false,
  location: 'USA',
  journalist_id: journalist.id
)
file = URI.open('https://networkingnerd.files.wordpress.com/2016/09/dumpsterfire2.jpg?w=584&h=584')
free_article.image.attach(io: file, filename: 'fire.jpg')

unpublished_article = Article.create(
  title: 'Bad and unpublished',
  lead: 'This article is poorly written',
  content: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.' * 10,
  category: 'sports',
  published: false,
  premium: false,
  location: 'Sweden',
  journalist_id: journalist.id
)
file = URI.open('https://reputationresolutions.com/wp-content/uploads/2018/02/Screen-Shot-2019-05-01-at-6.06.55-PM.png')
unpublished_article.image.attach(io: file, filename: 'bad.jpg')

## You need to continue doing this with every possible type of article (category and locations)