class MusicLibraryController
  attr_reader :path
  def initialize (path='./db/mp3s')
    new_importer=MusicImporter.new(path)
    new_importer.import
  end

  def play_song
    puts("Which song number would you like to play?")
    input=(gets.chomp.to_i)-1
    collection=Song.all.sort_by{|song| song.name}
    if collection[input]&& input>0 && input<=collection.length
      puts "Playing #{collection[input].name} by #{collection[input].artist.name}"
    end
  end


  def call

    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    user_input=gets.chomp
    case user_input
    when "list songs"
      self.list_songs
    when "list artists"
      self.list_artists
    when "list genres"
      self.list_genres
    when "list artist"
      self.list_songs_by_artist
    when "exit"
      "exit"
    else
      call
    end

  end

  def list_songs
  Song.all.sort_by  {|song| song.name}.each_with_index {|song,x| puts "#{x+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end

  def list_artists
  Artist.all.sort_by  {|artist| artist.name}.each_with_index {|artist,x| puts "#{x+1}. #{artist.name}"}
  end

  def list_genres
  Genre.all.sort_by  {|genre| genre.name}.each_with_index {|genre,x| puts "#{x+1}. #{genre.name}"}
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input=gets.chomp
    if artist=Artist.find_by_name(input)
    artist.songs.sort_by {|song| song.name}.each_with_index{|song,number| puts "#{number+1}. #{song.name} - #{song.genre.name}"}
  end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input=gets.chomp
    if genre=Genre.find_by_name(input)
    genre.songs.sort_by {|song| song.name}.each_with_index{|song,number| puts "#{number+1}. #{song.artist.name} - #{song.name}"}
  end
end

end
