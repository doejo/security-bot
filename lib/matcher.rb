class Matcher
  def initialize(config)
    @rules = config["rules"].map do |str|
      Regexp.new(config["format"].sub("RULE", str), Regexp::IGNORECASE)
    end
  end

  def match?(*items)
    str = items.join("\n")
    @rules.each { |rule| return true if rule.match(str) }
    false
  end
end