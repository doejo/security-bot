class Storage
  attr_reader :items

  def initialize(config)
    @path = config["storage"]
    raise "Please define storage" if !@path

    if !File.exists?(@path)
      File.open(@path, "w") { |f| f.write("") }
    end

    @items = File.readlines(@path).map(&:strip)
  end

  def include?(item)
    @items.index(item[:id]) != nil
  end

  def add(new_items)
    @items += new_items.map { |i| i[:id] }
  end

  def save
    File.open(@path, "w") do |f|
      f.write(items.uniq.sort.join("\n"))
    end
  end
end