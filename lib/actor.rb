class Actor
  attr_reader(:name, :id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_actors = DB.exec("SELECT * FROM actors;")
    actors = []
    returned_actors.each() do |actor|
      name = actor.fetch("name")
      id = actor.fetch("id").to_i()
      actors.push(Actor.new({:name => name, :id => id}))
    end
    actors
  end

  def self.find(id)
    result = DB.exec("SELECT * FROM actors WHERE id = #{id};")
    name = result.first().fetch("name")
    Actor.new({:name => name, :id => id})
  end


  def save
    result = DB.exec("INSERT INTO actors (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_actor)
    self.name().==(another_actor.name()).&(self.id().==(another_actor.id()))
  end

  def update(attributes)
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE actors SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM actors WHERE id = #{self.id()};")
  end
end
