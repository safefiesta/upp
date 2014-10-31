Gem::Specification.new do |s|
  s.name          = 'upp'
  s.version       = '0.0.1'
  s.authors       = ["Suttipong Wisittanakorn"]
  s.date          = "2014-10-30"
  s.summary       = "Simple Editor for Unity Player Prefs Files"
  s.description   = "This gem enable to view or edit Unity Player Prefs (.upp) files via CLI"
  s.email         = ["safe@nuxos.asia"]
  s.license       = "MIT"

  s.files         = Dir['README.md', 'lib/**/*']
  s.executables   = 'upp'
  s.require_paths = ["lib"]
end