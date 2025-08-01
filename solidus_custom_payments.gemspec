# frozen_string_literal: true

require_relative "lib/solidus_custom_payments/version"

Gem::Specification.new do |spec|
    spec.name = "solidus_custom_payments"
    spec.version       = SolidusCustomPayments::VERSION
    spec.authors       = ["Islam Odeh"]
    spec.email         = ["islamodeh@hotmail.com"]
    spec.summary       = "Configure custom payment methods."
    spec.description   = "Configure custom payment methods."
    spec.homepage      = "https://github.com/islamodeh"
    spec.license       = "BSD-3-Clause"

    spec.metadata["homepage_uri"]    = spec.homepage
    spec.metadata["source_code_uri"] = spec.homepage
    spec.metadata["changelog_uri"]   = "https://github.com/islamodeh/solidus_custom_payment_method/commits/master"

    spec.required_ruby_version = Gem::Requirement.new(">= 2.7", "< 4.0.0")

    files = Dir.chdir(__dir__) { %x(git ls-files -z).split("\x0") }
    spec.files         = files.grep_v(%r{^(test|spec|features)/})
    spec.bindir        = "exe"
    spec.executables   = files.grep(%r{^exe/}) { |f| File.basename(f) }
    spec.require_paths = ["lib"]

    # Runtime dependencies
    spec.add_dependency("rails", ">= 6.0", "< 9.0")
    spec.add_dependency("solidus_auth_devise", ">= 2.0")
    spec.add_dependency("solidus_core", [">= 2.5", "< 5.0"])

    spec.add_development_dependency("capybara")
    spec.add_development_dependency("database_cleaner")
    spec.add_development_dependency("factory_bot")
    spec.add_development_dependency("ffaker")
    spec.add_development_dependency("gem-release")
    spec.add_development_dependency("poltergeist")
    spec.add_development_dependency("rake")
    spec.add_development_dependency("rspec-rails")
    spec.add_development_dependency("simplecov")
    spec.add_development_dependency("solidus_dev_support")
    # spec.add_development_dependency "coffee-rails" # Only if you have CoffeeScript assets
    # spec.add_development_dependency "sass-rails" # Only if you have Sass assets
end
