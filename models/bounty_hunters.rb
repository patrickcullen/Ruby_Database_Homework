require("pg")

class BountyHunter
  attr_reader :id
  attr_accessor :name, :species, :favourite_weapon, :last_known_location

  def initialize(options)
    @id = options["id"].to_i
    @name = options["name"]
    @species = options["species"]
    @favourite_weapon = options["favourite_weapon"]
    @last_known_location = options["last_known_location"]
  end

  def save()
    db = PG.connect({ dbname: "cowboys", host: "localhost"})
    sql = "INSERT INTO cowboys (name, species, favourite_weapon, last_known_location)
     VALUES($1, $2, $3, $4) RETURNING id;"
    values = [@name, @species, @favourite_weapon, @last_known_location]
    db.prepare("save", sql)
    result = db.exec_prepared("save", values)
    db.close()
    @id = result[0]["id"].to_i
  end

  def delete()
    db = PG.connect({ dbname: "cowboys", host: "localhost"})
    sql = "DELETE FROM cowboys WHERE id = $1"
    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close()
  end

  def update()
    db = PG.connect({dbname: "cowboys", host: "localhost"})
    sql = "UPDATE cowboys SET (name, species, favourite_weapon, last_known_location)
    = ($1, $2, $3, $4) WHERE id = $5"
    values = [@name, @species, @favourite_weapon, @last_known_location, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def self.all()
    db = PG.connect({dbname: "cowboys", host: "localhost"})
    sql = "SELECT * FROM cowboys"
    db.prepare("all", sql)
    items = db.exec_prepared("all")
    db.close()
    return items.map {|item| BountyHunter.new(item)}
  end

  def self.delete_all()
    db = PG.connect({dbname: "cowboys", host: "localhost"})
    sql = "DELETE FROM cowboys"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def self.find_by_name(name)
    db = PG.connect({dbname: "cowboys", host: "localhost"})
    sql = "SELECT * FROM cowboys WHERE name = $1"
    values = [name]
    db.prepare("find_by_name", sql)
    result = db.exec_prepared("find_by_name", values)
    db.close()
    # return result[0]
    return result.map {|item| BountyHunter.new(item)}
  end

  def self.find_by_id(id)
    db = PG.connect({dbname: "cowboys", host: "localhost"})
    sql = "SELECT * FROM cowboys WHERE id = $1"
    values = [id]
    db.prepare("find_by_id", sql)
    result = db.exec_prepared("find_by_id", values)
    db.close()
    # return result[0]
    return result.map {|item| BountyHunter.new(item)}
  end

end
