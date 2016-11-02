require "bundler/setup"

task :run do
  require_relative "lib/runner"

  if !File.exists?("./config.yml")
    puts "Please create config.yml"
    exit 1
  end
  
  runner = Runner.new("./config.yml")
  period = ENV["RUN_PERIOD"].to_i

  if period > 0
    loop do
      runner.run
      sleep period
    end
  else
    runner.run
  end
end

task :test do
  require "yaml"
  require_relative "lib/matcher"
  Matcher.new(YAML.load_file("./config.yml"))
end