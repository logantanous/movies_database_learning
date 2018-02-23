require('sinatra')
require('sinatra/reloader')
require('./lib/movie')
require('./lib/actor')
also_reload('lib/**/*.rb')
require("pg")
require("pry")


DB = PG.connect({:dbname => "movie_database_test"})

# get("/") do
#   @lists = List.all()
#   erb(:index)
# end
#
# get("/lists/new") do
#   erb(:list_form)
# end
#
# get("/lists") do
#  @lists = List.all()
#  erb(:lists)
# end
#
# post("/lists") do
#   name = params.fetch("name")
#   list = List.new({:name => name, :id => nil})
#   list.save()
#   erb(:success)
# end
#
# get("/lists/:id") do
#   @list = List.find(params.fetch("id").to_i())
#   erb(:list)
# end
#
# post("/tasks") do
#   description = params.fetch("description")
#   list_id = params.fetch("list_id").to_i()
#   @list = List.find(list_id)
#   @task = Task.new({:description => description, :list_id => list_id})
#   @task.save()
#   erb(:task_success)
# end
