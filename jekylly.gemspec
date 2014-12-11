$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "jekylly/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "jekylly"
  s.version     = Jekylly::VERSION
  s.authors     = ["James Smith"]
  s.email       = ["james@floppy.org.uk"]
  s.homepage    = "https://github.com/OpenAddressesUK/jekylly"
  s.summary     = "A rails engine for rendering Jekyll-like pages"
  s.description = "Allows you to use the jekyll site layout, including data and posts, to manage static content in a rails app"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE.md", "Rakefile", "README.md"]
  s.test_files = [] #Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.7"
  s.add_dependency "kramdown"
  
end
