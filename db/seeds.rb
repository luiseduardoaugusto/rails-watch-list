# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'

Movie.destroy_all 
List.destroy_all

movies = URI.open("http://tmdb.lewagon.com/movie/top_rated").read

movies = JSON.parse(movies)
movies["results"].each do |movie|
  if movie["original_language"] == "en"
    pelicula = Movie.new
    pelicula.title =           movie["original_title"]
    pelicula.overview =        movie["overview"]
    pelicula.poster_url =     "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}"
    pelicula.rating =           movie["vote_average"]
    pelicula.save
  end
end


List.create!( name: "drama")
List.create!( name: "accion")
List.create!( name: "comedia")
List.create!( name: "suspenso")
