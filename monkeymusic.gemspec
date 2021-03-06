Gem::Specification.new do |s|
  s.name        = "monkeymusic"
  s.version     = "0.1.5"
  s.license     = "MIT"
  s.author      = "Oscar Soderlund"
  s.email       = "poscar@spotify.com"
  s.homepage    = "https://github.com/odsod/monkey-music"
  s.summary     = "A runtime for an AI programming competition."
  s.description = "n/a"
  s.files        = Dir["{demo_players,lib,levels,bin,users}/**/*", "[A-Z]*", "init.rb"]
  s.require_path = "lib"
  s.executables  = ["monkeymusic"]
  s.add_dependency "json"

  s.rubyforge_project = s.name
  s.required_rubygems_version = ">= 1.3.4"
end
