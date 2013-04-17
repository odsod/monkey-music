Gem::Specification.new do |s|
  s.name        = "monkeymusic"
  s.version     = "0.0.1"
  s.author      = "Oscar Soderlund"
  s.email       = "oscar.d.soderlund@gmail.com"
  s.homepage    = "https://github.com/odsod/monkey-music"
  s.summary     = "A runtime for an AI programming competition."
  s.description = "TBA"

  s.files        = Dir["{lib,levels,bin}/**/*", "[A-Z]*", "init.rb"]
  s.require_path = "lib"
  s.executables  = ["monkeymusic"]

  s.rubyforge_project = s.name
  s.required_rubygems_version = ">= 1.3.4"
end
