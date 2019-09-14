require "pry"
class Song
  attr_accessor :name
  attr_reader :artist, :genre
  @@all=[]

  extend Concerns::Findable

  def initialize (name,artist=nil,genre=nil)
    @name=name
    self.artist=artist
    self.genre=genre
    save
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.new_from_filename (path)
    new_song=path.split(" - ")
    name=new_song[1]
    artist=new_song[0]
    genre=new_song[2].gsub(".mp3","")
    x=Artist.find_or_create_by_name(artist)
    y=Genre.find_or_create_by_name(genre)
    self.new(name,x,y)
  end

  def self.create_from_filename (path)
    self.new_from_filename(path)
  end

  def self.create (song)
    self.new(song)
  end

  def save
    @@all<<self
  end

  def artist= (artist)
    @artist=artist
    artist && artist.add_song(self)
  end

  def genre= (genre)
    @genre=genre
    genre && genre.add_song(self)
  end

end
