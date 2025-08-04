# frozen_string_literal: true

group :development, :test do
    gem "embold_ruby_style", github: "emboldagency/embold_ruby_style", branch: "main"
    gem "observer"
    gem "rake"
    # Use the appropriate database adapter for your environment (for dummy app)
    if ENV["DB"] == "mysql"
        gem "mysql2", "~> 0.4.10"
    else
        gem "pg", "~> 0.21"
    end
end

ruby "~> 3.0"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
