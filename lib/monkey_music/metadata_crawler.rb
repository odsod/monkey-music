require 'hallon'

appkey_path = File.expand_path('./spotify_appkey.key')
appkey = IO.read(appkey_path)
username = "poscar!"
password = "405430"
session = Hallon::Session.initialize(appkey)
session.login!(username, password)

# First, I need the power to ask you questions. You need not care much about this particular
# piece of me; only keep in mind that it should help keep the rest of me less cluttered.
def prompt(string, options = {})
  print(string + ': ')
  $stdout.flush
  system("stty -echo") if options[:hide]
  gets.chomp
ensure
  if options[:hide]
    system("stty echo")
    puts
  end
end

while username = prompt("Enter a Spotify username: ")
  begin
    puts "Loading #{username}."
    user = Hallon::User.new(username)

    top_tracks = Hallon::Toplist.new(:tracks, username)
    top_tracks.load
    top_tracks.results.each { |r| puts r.to_link.to_str; puts r.name }

    top_albums = Hallon::Toplist.new(:albums, username)
    top_albums.load
    top_albums.results.each { |r| puts r.to_link.to_str; puts r.name }

    top_artists = Hallon::Toplist.new(:artists, username)
    top_artists.load
    top_artists.results.each { |r| puts r.to_link.to_str; puts r.name }

    #puts "Fetching published playlists for #{username}..."
    #published = user.published.load

    #puts "Loading #{published.size} playlists."
    #all_playlists = published.contents.find_all do |playlist|
      #playlist.is_a?(Hallon::Playlist) # ignore folders
    #end

    #all_playlists.each(&:load)

    #all_playlists.each do |playlist|
      #puts
      #puts "Listing tracks for #{playlist.name} (#{playlist.to_str}):"

      #tracks = playlist.tracks.to_a.map(&:load)
      #tracks.each_with_index do |track, i|
        #puts "\t (#{i+1}/#{playlist.size}) #{track.name}"
      #end
    #end
  rescue Interrupt
    puts "Interrupted!"
  end
end
