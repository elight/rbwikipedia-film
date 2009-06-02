My wife and I hate physical media.  Sure, we own (a ton of) DVDs -- but I've had many go AWOL or suffer scratches
and become entirely unusable!

Instead, we have two AppleTVs and a server running iTunes.  I *gasp* commit Fair User of my DVDs, convert them
to MP4, and, with the help of this gem, for the past couple of years, I've been adding synopsis and movie posters
to the iTunes database so that my wife has some idea what all of the movies are about.

(Nevermind that most of them are either anime, involve stuff blowing up, people getting shot, or are nerd 
comedies... but at least she has movie posters, dammit!)

It's pretty simple to use:

require 'rubygems'
require 'rbwikipedia-film'

star_wars = Film.get_by_title('Star Wars')

# Get the movie synopsis
@synopsis = star_wars.synopsis

# Write the movie poster out to a file in the /tmp directory
star_wars.write_poster_to "/tmp"

File.open("/tmp/#{star_wars.poster_img_hash[:filename]}") do |the_poster|
  ...
end

