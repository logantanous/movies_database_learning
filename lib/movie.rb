class Movie
  attr_reader(:name, :id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_movies = DB.exec("SELECT * FROM movies;")
    movies = []
    returned_movies.each() do |movie|
      name = movie.fetch("name")
      id = movie.fetch("id").to_i()
      movies.push(Movie.new({:name => name, :id => id}))
    end
    movies
  end

  def self.find(id)
    result = DB.exec("SELECT * FROM movies WHERE id = #{id};")
    name = result.first().fetch("name")
    Movie.new({:name => name, :id => id})
  end

  def save
    result = DB.exec("INSERT INTO movies (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_movie)
    self.name().==(another_movie.name()).&(self.id().==(another_movie.id()))
  end

  def update(attributes)
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE movies SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM movies WHERE id = #{self.id()};")
  end
end
