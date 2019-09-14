require "pry"
class MusicImporter
  attr_reader :path
  def initialize (path)
    @path=path
  end

  def files
    Dir.entries(path).select {|files| files.match(".mp3")}
  end

  def import
    self.files.each {|file| Song.create_from_filename(file)}
  end

end
