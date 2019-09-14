require"pry"

class Artist
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

  def self.create (artist)
    self.new(artist)
  end

  def add_song (song)
    song.artist=self unless song.artist
    @songs<<song unless
    @songs.include? (song)
  end

  def genres
    self.songs.collect {|song| song.genre}.uniq
  end

end
