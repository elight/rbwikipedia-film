Gem::Specification.new do |s|
  s.name = %q{rbwikipedia}
  s.version = "0.1.0"
  s.date = %q{2008-10-26}
  s.summary = %q{Wikipedia search and Film metadata extraction}
  s.email = %q{sleight42@gmail.com}
  s.homepage = %q{http://rbwikipedia.rubyforge.org}
  s.rubyforge_project = %q{rbwikipedia}
  s.description = %q{Wikipedia search and Film metadata extraction}
  s.has_rdoc = true
  s.required_ruby_version = Gem::Version::Requirement.new(">= 0")
  s.cert_chain = []
  s.authors = ["Evan Light"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "Rakefile", "lib/rbwikipedia-film.rb", "lib/rbwikipedia-film/version.rb", "lib/rbwikipedia-film/film.rb", "lib/rbwikipedia-film/search.rb", "lib/rbwikipedia-film/fetch.rb", "setup.rb", "test/test_helper.rb", "test/test_film.rb", "test/test_search.rb"]
  s.test_files = ["test/test_film.rb", "test/test_helper.rb", "test/test_search.rb"]
  s.rdoc_options = ["--main", "README.txt"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.add_dependency(%q<hoe>, [">= 1.8.1"])
end
