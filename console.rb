require("pry-byebug")
require_relative('./models/bounty_hunters.rb')

BountyHunter.delete_all()

cowboy1 = BountyHunter.new({
  "name" => "Malcolm",
  "species" => "Mancunian",
  "favourite_weapon" => "Club",
  "last_known_location" => "Salford"
  })

cowboy1.save()

cowboy2 = BountyHunter.new({
  "name" => "Walter",
  "species" => "Cockney",
  "favourite_weapon" => "Blade",
  "last_known_location" => "Swindon"
  })

cowboy2.save()

binding.pry
nil
