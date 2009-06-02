$LOAD_PATH << File.dirname(__FILE__)
require 'net/http'

module Wikipedia
  class Search
	  require 'fetch'
	  
	  SEARCH_PG_PTN = 'wgPageName = "Special:Search";'
	  SEARCH_ITEM_START_PTN = '<li style="padding-bottom: 1em;">'
	  SEARCH_ITEM_END_PTN = '</li>'
	  ITEM_HIT_START = '<a href='
	  
	  # <i>wiki_url</i>: The URL of the wiki to search
	  def initialize(wiki_url)
	    wiki_url.chop! if wiki_url =~ /\/$/m
	    @wiki_url = wiki_url
	    @search_url = wiki_url + "/wiki/Special:Search"
    end

    def search(query_str)
      response = Net::HTTP.post_form URI.parse(@search_url), :search => query_str, :search => "Search"
      if response.body =~ /#{SEARCH_PG_PTN}/m
        results = multiple_search_results_in response
      elsif response.is_a? Net::HTTPRedirection
        results = fetch(response['location']).body
      end
    end

    def go(query_str)
      response = Net::HTTP.post_form URI.parse(@search_url), :search => query_str, :go => "Go"
     
      if response.is_a? Net::HTTPRedirection
        fetch(response['location']).body
      else
        response.body  
      end
    end
    
    private

    def is_disambiguation_page?(response)
      response.body =~ /"Wikipedia:Disambiguation">disambiguation<\/a> page/m
    end

    def convert_disambiguation_page_into_hit_list(response)
      raw = response.body.split(/#{SEARCH_ITEM_START_PTN}|#{SEARCH_ITEM_END_PTN}/)
      hits = raw.select { |l| l =~ /^#{ITEM_HIT_START}/ }
      hits.collect do |h|
        h =~ /href="(.*)" title.*>(.*)<\/a>.*Relevance: (.*)%/m
        { :url => @wiki_url + $1, :title => $2, :weight => $3 }
      end
    end
  end
end


