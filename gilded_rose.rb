def update_quality(items)
  items.each {|item| verify_item(item)}
end

def verify_sellin(param)
  sell_in ={
    "< 0" => lambda {puts "hola marce linda "},
    "< 6"=> lambda {},
    "< 11"=> lambda {}
  }
  sell_in[param].call
end

def increase_quality(item)
  item.quality += 1
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

def verify_quality(param)
  quality = {
    " > 0" => lambda {},
    " < 50" => lambda {}
  }
  quality[param].call
end

ESPECIAL_NAMES =[ "Sulfuras, Hand of Ragnaros", "Aged Brie", "Backstage passes to a TAFKAL80ETC concert"]

def verify_name(param, item)
  names = {
    "Sulfuras, Hand of Ragnaros"=> lambda {},
    "Aged Brie"=> lambda { item.sell_in -= 1 },
    "Backstage passes to a TAFKAL80ETC concert"=> lambda {decrease_sell_in(item) }
  }
  names[param] || lambda { item.sell_in -= 1}
end

def ranger(number1,number2)
  number1 > number2
end

def comparer_than_(number1,number2)
  number1 > number2
end


def not_special_name?(name)
  !ESPECIAL_NAMES.include?(name)
end

def verify_item(item)
  if item.quality < 50 and !(item.name != 'Aged Brie' && item.name != 'Backstage passes to a TAFKAL80ETC concert')
    increase_quality(item)
    if item.sell_in < 11 and item.name == 'Backstage passes to a TAFKAL80ETC concert'
      increase_quality(item)
    end
    if item.sell_in < 6 and item.name == 'Backstage passes to a TAFKAL80ETC concert'
      increase_quality(item)
    end
  end

  verify_name(item.name, item).call

  decrease_quality(item, 1) if item.quality > 0 and not_special_name?(item.name) and item.sell_in > 0
  decrease_quality(item, 2) if item.quality > 0 and not_special_name?(item.name) and item.sell_in < 0

  if item.name == 'Backstage passes to a TAFKAL80ETC concert' and item.name != "Aged Brie" and item.sell_in < 0
    set_quality_zero(item)
  end

  if item.quality < 50 and item.name == "Aged Brie" and item.sell_in < 0
    increase_quality(item)
  end
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

