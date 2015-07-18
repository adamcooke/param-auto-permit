Gem::Specification.new do |s|
  s.name          = "param_auto_permit"
  s.description   = %q{A Rails extension to avoid duplicating attribute lists between forms & controllers}
  s.summary       = s.description
  s.homepage      = "https://github.com/adamcooke/param-auto-permit"
  s.version       = "1.0.0"
  s.files         = Dir.glob("{lib}/**/*")
  s.require_paths = ["lib"]
  s.authors       = ["Adam Cooke"]
  s.email         = ["me@adamcooke.io"]
  s.licenses      = ['MIT']
end
