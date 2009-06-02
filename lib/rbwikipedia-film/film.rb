$LOAD_PATH << File.dirname(__FILE__)
require 'net/http'
require 'uri'
require 'cgi'

module Wikipedia
  class Film
    require 'fetch'
     
    TITLE_PAT = '<td colspan="2" class="summary" style="text-align:center; font-size: 125%; font-weight: bold; font-size: 110%;"><i>(.*?)(<\/i>?)'
    POSTER_PAT = 'colspan="2".*><a href=(".*?")'
    POSTER_SRC_PAT = '<img(.*?)src="(.*?)"'
    REL_DATE_PAT = '<th>Release.*?<\/th><td><a.*?>(.*?)<\/a>(, <a.*?>(.*?)<)?'
    SYNOPSIS_PAT = '<p>(.*?)<\/p>'

    WIKIPEDIA = "http://en.wikipedia.org"
    
    attr_reader :html, :title, :poster_img_hash, :synopsis
    
    def Film.get_by_title(t)
      begin
        html = go_get_it(t, " (Film)")
      rescue
        html = go_get_it(t)
      end
      begin
        f = Film.new html, Film::WIKIPEDIA
      rescue Exception
        html = go_get_it(t)
        f = Film.new html, Film::WIKIPEDIA
      end
      f
    end

    def initialize(film_html, wiki_url)
      @html = film_html
      @wiki_url = (wiki_url =~ /\/$/m ? wiki_url.chop : wiki_url)
      parse
    end

    def write_poster_to(path)
      File.open(path + "/" + @poster_img_hash[:filename], "wb") do |out|
        out.write(@poster_img_hash[:image])
      end
    end
    
    def fetch_poster
      @html =~ /#{POSTER_PAT}/
      raise Exception.new("Couldn't find poster URL") unless $1
      url = $1.gsub(/"/m, "")
      image_page_html = fetch(@wiki_url + url).body
      begin   
        image_page_html =~ /#{POSTER_SRC_PAT}/m
        image_url = $2
      rescue Exception
        raise Exception.new("A problem occurred fetching the poster from #{@wiki_url + $1}")
      end
      
      filename = image_url.match(/.*\/(.*)$/m)[1] 
      return { :filename => filename, :image => fetch(image_url).body }
    end  

    def parse
      @html =~ /#{TITLE_PAT}/m
      if $1
        @title = $1.gsub(/<br \/>/m, " ") 
        @title.gsub!(/\n/, "") 
      end
      
      @poster_img_hash = fetch_poster

      @html =~ /#{SYNOPSIS_PAT}/m
      if $1 
        @synopsis = $1.gsub(/<\/?[^>]*>/m, "")
        # Wikipedia uses evil MS Word "smart quotes"
        @synopsis.gsub! "\342\200\230", "'"
        @synopsis.gsub! "\342\200\231", "'"
        @synopsis.gsub! "\342\200\234", '"'
        @synopsis.gsub! "\342\200\235", '"'
        @synopsis = @synopsis[0,139] + "..."
      end
    end
  end
  
  private
    def Film.go_get_it(t, suffix="")
      wikipedia = Search.new Film::WIKIPEDIA
      wikipedia.go(t + suffix)
    end
end
