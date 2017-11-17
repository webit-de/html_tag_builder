
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "html_tag_builder/version"

Gem::Specification.new do |spec|
  spec.name          = "html_tag_builder"
  spec.version       = HtmlTagBuilder::VERSION
  spec.authors       = ["Christoph Wagner"]
  spec.email         = ["wagner@webit.de"]

  spec.summary       = %q{Easy generation of nested html tags}
  spec.description   = %q{tag and content_tag helper to build html tags like rails does}
  spec.homepage      = "https://github.com/webit-de/html_tag_builder"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "erbse", "~> 0.1.1"
end
