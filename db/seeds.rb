# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# user1 = User.create({ username: "Test User", email:"test@test.com", logged_in:true, in_game:false, password:"test"})
# stat1 = Stat.create({ wins: 0, losses: 0, card_count: 6 })
# user1.stat = stat1
# user2 = User.create({ username: "apple", email:"apple@test.com", logged_in:true, in_game:false, password:"test"})
# stat2 = Stat.create({ wins: 0, losses: 0, card_count: 6 })
# user3 = User.create({ username: "bana", email:"banana@test.com", logged_in:true, in_game:false, password:"test"})
# stat3 = Stat.create({ wins: 0, losses: 0, card_count: 6 })



names = [ "Leon", "James", "Nick", "Dean", "Melissa", "Ka", "Tim", "EJ", "Catherine", "Charith", "Micah", "Paul W", "Paul M", "Kerrie", "Chloe", "Duyen", "Ari", "Pedro", "Sean", "Jason", "Bruno", "Harry", "Kasun", "DT", "Matt"]
earth = [2360, 730, 1960, 2260, 1970, 970, 2790, 2060, 2200, 3570, 610, 1230, 4280, 3980, 3720, 2440, 1310, 3770, 3950, 4280, 1670, 2660, 590, 4130, 3810]
wind = [2530, 1100, 4890, 1550, 2640, 4560, 4220, 4130, 1540, 3650, 4290, 2920, 2830, 4700, 1210, 1870, 1120, 1260, 1260, 2070, 3870, 1880, 4650, 2470, 1080]
fire = [320, 60, 3790, 2290, 440, 2690, 2880, 2290, 3670, 2770, 3990, 3320, 1800, 460, 2780, 2980, 2110, 3360, 2930, 4480, 2000, 340, 1020, 3450, 710]
specials = ["Hot Chocolate", "Nosiness", "Gadgets", "Sleepless", "Parrots", "Quietly competent", "Mr Music", "Sasquatch Fancier", "Wordsmith", "Calorie King", "Tree Whisperer", "Beer Connoisseur", "Normal Man", "Caring Engineer", "Magician", "Artist", "Batman", "Nice Hair Nice House", "Poker Face", "Smiley", "Mr Suave", "Delinquent", "Patience", "Cakepudding", "B.O.S.S"]
images = ["avatars/leon.png",
          "avatars/james.png",
          "avatars/nick.png",
          "avatars/dean.png",
          "avatars/melissa.png",
          "avatars/ka.png",
          "avatars/tim.png",
          "avatars/ej.png",
          "avatars/catherine.png",
          "avatars/chaz.png",
          "avatars/micah.png",
          "avatars/paulw.png",
          "avatars/paulm.png",
          "avatars/kerrie.png",
          "avatars/chloe.png",
          "avatars/duyen.png",
          "avatars/ari.png",
          "avatars/pedro.png",
          "avatars/sean.png",
          "avatars/jason.png",
          "avatars/bruno.png",
          "avatars/harry.png",
          "avatars/kasun.png",
          "avatars/dt.png",
          "avatars/matt.png",
        ]
sad_images = ["sadavatar/leon-lose.png",
          "sadavatar/james-lose.png",
          "sadavatar/nick-lose.png",
          "sadavatar/dean-lose.png",
          "sadavatar/melissa-lose.png",
          "sadavatar/ka-lose.png",
          "sadavatar/tim-lose.png",
          "sadavatar/ej-lose.png",
          "sadavatar/catherine-lose.png",
          "sadavatar/chaz-lose.png",
          "sadavatar/micah-lose.png",
          "sadavatar/paulw-lose.png",
          "sadavatar/paulm-lose.png",
          "sadavatar/kerrie-lose.png",
          "sadavatar/chloe-lose.png",
          "sadavatar/duyen-lose.png",
          "sadavatar/ari-lose.png",
          "sadavatar/pedro-lose.png",
          "sadavatar/sean-lose.png",
          "sadavatar/jason-lose.png",
          "sadavatar/bruno-lose.png",
          "sadavatar/harry-lose.png",
          "sadavatar/kasun-lose.png",
          "sadavatar/dt-lose.png",
          "sadavatar/matt-lose.png",
        ]



Card.destroy_all
names.each_with_index do |name, index|
  Card.create({ name:name, earth:earth[index], wind:wind[index], fire:fire[index], special:specials[index], image_url: images[index], sad_image_url: sad_images[index]})
end


User.destroy_all
3.times do |count|
  new_user = User.new

  new_user.username = 'user' + count.to_s
  new_user.email = 'email' + count.to_s + '@gmail.com'
  new_user.password = 'test'

  new_user.logged_in = true
  new_user.in_game = false
  new_user.save
  6.times do
    new_user.cards << Card.all.sample
  end
  new_stat = Stat.create({ wins: 0, losses:0 , card_count: new_user.cards.count })
  new_user.stat = new_stat
end
