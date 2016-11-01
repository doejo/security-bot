require "rss"

class Fetcher
  def initialize(config)
    @urls = config["feeds"]
  end

  def fetch
    items = []

    @urls.each do |url|
      feed = RSS::Parser.parse(Faraday.get(url).body)

      feed.items.each do |item|
        items << {
          id:      item.guid.content,
          title:   item.title,
          content: item.description,
          link:    item.link,
        }
      end
    end

    items
  end
end