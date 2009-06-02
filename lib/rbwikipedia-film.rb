Dir[File.join(File.dirname(__FILE__), 'rbwikipedia-film/**/*.rb')].sort.each { |lib| require lib }
