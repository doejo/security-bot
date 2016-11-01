require "yaml"

require_relative "storage"
require_relative "fetcher"
require_relative "matcher"
require_relative "notifier"

class Runner
  def initialize(config_path)
    @config_path = config_path
  end

  def run
    config   = YAML.load_file(@config_path)
    storage  = Storage.new(config)
    fetcher  = Fetcher.new(config)
    matcher  = Matcher.new(config)
    notifier = Notifier.new(config)

    # Fetch all items from all feeds and filter through.
    # Items will only include new and matched items.
    items = fetcher.fetch.select do |item|
      matcher.match?(item[:title], item[:content]) && !storage.include?(item)
    end
  
    # We dont want to do anything if there are no matches    
    if items.empty?
      puts "No matches found"
      return
    else
      puts "Saving #{items.size} matches"
    end

    notifier.notify(items)
    storage.add(items)
    storage.save
  end
end