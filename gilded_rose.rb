def update_quality(items)
  items.each {|item| verify_item(item)}
end

def increase_quality(item, amount)
  item.quality += amount
end

def decrease_quality(item, amount)
  item.quality -= amount
end

def set_quality_zero(item)
  item.quality = 0
end

def decrease_sell_in(item)
  item.sell_in -= 1
end

def verify_quality(param, item)
  quality = {
    0 => lambda { item.quality > 0},
    50 => lambda { item.quality < 50 }
  }
  quality[param].call
end

ESPECIAL_NAMES =[ "Sulfuras, Hand of Ragnaros", "Aged Brie", "Backstage passes to a TAFKAL80ETC concert"]

def verify_sell_in(param, item)
  names = {
    "Sulfuras, Hand of Ragnaros"=> lambda {},
    "Aged Brie"=> lambda { },
    "Backstage passes to a TAFKAL80ETC concert"=> lambda {decrease_sell_in(item) }
  }
  names[param] || lambda { decrease_sell_in(item)}
end

def verify_name(param, item)
  names = {
    "Sulfuras, Hand of Ragnaros"=> lambda {},
    "Aged Brie"=> lambda { decrease_sell_in(item)},
    "Backstage passes to a TAFKAL80ETC concert"=> lambda {decrease_sell_in(item) }
  }
  names[param] || lambda { decrease_sell_in(item)}
end

def comparer_than_(number1,number2)
  number1 > number2
end

def verify_item(item)
  verify_quality(50, item) && ESPECIAL_NAMES.last(2).include?(item.name) && increase_quality(item, 1)
  verify_quality(50, item) && ESPECIAL_NAMES.last(2).include?(item.name) && item.sell_in < 11 && ESPECIAL_NAMES.last.include?(item.name) && increase_quality(item, 1)
  verify_quality(50, item) && ESPECIAL_NAMES.last(2).include?(item.name) && item.sell_in < 6 && ESPECIAL_NAMES.last.include?(item.name)  && increase_quality(item, 1)

  verify_name(item.name, item).call

  verify_quality(0, item) && item.quality > 0 && !ESPECIAL_NAMES.include?(item.name) && item.sell_in > 0 && decrease_quality(item, 1)
  verify_quality(0, item) && !ESPECIAL_NAMES.include?(item.name) && item.sell_in < 0 && decrease_quality(item, 2) 

  ESPECIAL_NAMES.last.include?(item.name) && item.name != "Aged Brie" && item.sell_in < 0 && set_quality_zero(item)

  verify_quality(50, item) && item.name == "Aged Brie" && item.sell_in < 0 && increase_quality(item, 1)
end


# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]

