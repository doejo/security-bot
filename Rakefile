require "bundler/setup"

task :run do
  require_relative "lib/runner"
  Runner.new("./config.yml").run
end

task :test do
  require "yaml"
  require_relative "lib/matcher"
  Matcher.new(YAML.load_file("./config.yml"))
end