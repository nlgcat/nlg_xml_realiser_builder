# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nlg_xml_realiser_builder/version'

Gem::Specification.new do |spec|
  spec.name          = "nlg_xml_realiser_builder"
  spec.version       = NlgXmlRealiserBuilder::VERSION
  spec.authors       = ["Fabio Akita"]
  spec.email         = ["boss@akitaonrails.com"]

  spec.summary       = %q{Builder for Simple NLG XML format}
  spec.description   = %q{Builds Simple NLG compatible XML recordings}
  spec.homepage      = "https://github.com/Codeminer42/nlg_xml_realiser_builder"
  spec.license       = "LGPL"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.10.4"

  spec.add_runtime_dependency "nokogiri", "~> 1.6.8.1"
end
