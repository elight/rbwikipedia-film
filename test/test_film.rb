require File.dirname(__FILE__) + '/test_helper.rb'

include Wikipedia

# This test is fragile as it integrates with a wikipedia document -- but we need to know if the standard Film template changes too....
class TestFilm < Test::Unit::TestCase

  WIKIPEDIA = "http://en.wikipedia.org"

  def setup
    @film = Film.get_by_title "Star Wars"
  end

  def test_new
    assert @film
  end

  def test_new_with_empty_strs
    assert_raises Exception do
      Film.new("", "")
    end
  end

  def test_title
    assert_equal @film.title, "Star Wars Episode IV: A New Hope"
  end

  def test_synopsis
    assert_equal "Star Wars Episode IV: A New Hope, originally released simply as Star Wars,[2] is an American 1977 space opera film,[3] written and directed...", 
                 @film.synopsis 
  end
  
  def test_poster_exists
    assert_not_nil @film.poster_img_hash
  end
  
  def test_poster_filename
    assert_equal @film.poster_img_hash[:filename], "398px-StarWarsMoviePoster1977.jpg"
  end
  
  def test_poster_image
    assert_not_nil @film.poster_img_hash[:image]
  end
  
  def test_write_poster_to
    assert_nothing_raised do
      @film.write_poster_to "/tmp"
    end
  end
end
