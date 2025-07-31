# encoding: utf-8
# frozen_string_literal: true

$LOAD_PATH.push(File.expand_path("../lib", __FILE__))
require "solidus_custom_payments/version"

Gem::Specification.new do |s|
    s.name = "solidus_custom_payments"
    s.version     = SolidusCustomPayments::VERSION
    s.summary     = "Configure custom payment methods."
    s.description = "Configure custom payment methods."
    s.license     = "BSD-3-Clause"

    s.author    = "Islam Odeh"
    s.email     = "islamodeh@hotmail.com"
    s.homepage  = "https://github.com/islamodeh"

    s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]

    branch = ENV.fetch("SOLIDUS_BRANCH", "main")
    s.add_dependency("rails", ">= 6.0", "< 9.0")
    s.add_dependency("solidus", github: "solidusio/solidus", branch: branch)
    s.add_dependency("solidus_auth_devise", ">= 2.0")
    s.add_dependency("solidus_core", ">= 2.5", "< 5.0")
    if branch < "v2.5"
        s.add_development_dependency("factory_bot", "4.10.0")
    else
        s.add_development_dependency("factory_bot", "> 4.10.0")
    end

    s.add_development_dependency("capybara")
    s.add_development_dependency("coffee-rails")
    s.add_development_dependency("database_cleaner")
    s.add_development_dependency("ffaker")
    s.add_development_dependency("gem-release")
    s.add_development_dependency("poltergeist")
    s.add_development_dependency("rake")
    s.add_development_dependency("rspec-rails")
    s.add_development_dependency("sass-rails")
    s.add_development_dependency("simplecov")
end
