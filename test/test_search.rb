require File.dirname(__FILE__) + '/test_helper.rb'

include Wikipedia

WIKIPEDIA = "http://en.wikipedia.org"

class TestWikipedia < Test::Unit::TestCase

  def test_new_search
    assert_not_nil Search.new(WIKIPEDIA)
  end
 
  def test_search
    wikipedia = Search.new WIKIPEDIA
    assert_not_nil wikipedia.go("Star Wars Episode IV: A New Hope")
  end
end
