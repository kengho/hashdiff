$LOAD_PATH << File.expand_path("../lib", __FILE__)
require 'hashdiff_sym/version'

Gem::Specification.new do |s|
  s.name        = %q{hashdiff_sym}
  s.version     = HashDiffSym::VERSION
  s.license     = 'MIT'
  s.summary     = %q{ HashDiffSym is a diff lib to compute the smallest difference between two hashes. }
  s.description = %q{ HashDiffSym is a diff lib to compute the smallest difference between two hashes. }

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- Appraisals {spec}/*`.split("\n")

  s.require_paths = ['lib']
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")

  s.authors = ["Liu Fengyun", "Alexander Morozov"]
  s.email   = ["ntcomp12@gmail.com"]

  s.homepage = "https://github.com/kengho/hashdiff_sym"

  s.add_development_dependency("rspec",    "~> 2.0")
  s.add_development_dependency("yard")
  s.add_development_dependency("bluecloth")
end
