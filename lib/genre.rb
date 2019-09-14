require "pry"
class Genre
  attr_accessor :name
  attr_reader :songs
  @@all=[]

  extend Concerns::Findable

  def initialize (name)
    @name=name
    @songs=[]
    save
  end

  def save
    @@all<<self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create (genre)
    self.new(genre)
  end

  def add_song (song)
    song.genre=self unless song.genre
    @songs<<song unless @songs.include? (song)
  end

  def artists
    self.songs.collect {|song| song.artist}.uniq
  end
end
