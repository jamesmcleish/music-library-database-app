# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  post '/albums' do
    title = params[:title]
    release_year = params[:release_year]
    artist_id = params[:artist_id]

    repo = AlbumRepository.new
    album = Album.new

    album.title = title
    album.release_year = release_year
    album.artist_id = artist_id

    repo.create(album)
    return ''
  end

  get '/albums' do 
    repo = AlbumRepository.new
    album = Album.new
    string = ''
    repo.all.each do |album_instance|
      string += album_instance.title
      string += ', '
    end
    return string
  end

  get '/artists' do
    repo = ArtistRepository.new
    artist = Artist.new
    string = ''
    repo.all.each do |artist_instance|
      string += artist_instance.name
      string += ', '
    end
    2.times do
      string.chop!
    end
    return string
  end

  post '/artists' do
    repo = ArtistRepository.new
    artist = Artist.new

    name = params[:name]
    genre = params[:genre]

    artist.name = name
    artist.genre = genre

    repo.create(artist)
    return ''
  end
end

