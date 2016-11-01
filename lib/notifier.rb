require "json"
require "faraday"

class Notifier
  def initialize(config)
    @config = config

    raise "Please setup webhook" if !@config["webhook"]
    raise "Please setup channel" if !@config["channel"]
  end

  def notify(items)
    return if items.empty?

    payload = {
      username:    "Security Bot",
      icon_url:    "https://cdn2.iconfinder.com/data/icons/windows-8-metro-style/128/bug.png",
      channel:     ENV["SLACK_CHANNEL"] || @config["channel"],
      text:        "New vulnerabilities found!",
      attachments: items.map { |item| format_item(item) }
    }

    # Do not send anything to slack if in debug mode.
    # Useful for testing.
    if ENV["DEBUG"]
      puts "Test Slack Payload:"
      puts JSON.dump(payload)
      return
    end

    Faraday.post(@config["webhook"]) do |req|
      req.headers["Content-Type"] = "application/json"
      req.body = JSON.dump(payload)
    end
  end

  private

  def format_item(item)
    {
      title:      item[:title],
      title_link: item[:link],
      color:      "danger",
    }
  end
end