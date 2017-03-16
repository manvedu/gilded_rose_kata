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

def verify_name(param, item)
  names = {
    "Sulfuras, Hand of Ragnaros"=> lambda {},
    "Aged Brie"=> lambda { item.sell_in -= 1 },
    "Backstage passes to a TAFKAL80ETC concert"=> lambda {item.sell_in -= 1 }
  }
  names[param] || lambda { item.sell_in -= 1}
end

def verify_quality(param)
  quality = {
    " > 0" => lambda {},
    " < 50" => lambda {}
  }
  quality[param].call
end

def verify_item(item)
  if item.quality < 50 and !(item.name != 'Aged Brie' && item.name != 'Backstage passes to a TAFKAL80ETC concert')
    item.quality += 1
    if item.sell_in < 11 and item.quality < 50 and item.name == 'Backstage passes to a TAFKAL80ETC concert'
      item.quality += 1
    end
    if item.sell_in < 6 and item.quality < 50 and item.name == 'Backstage passes to a TAFKAL80ETC concert'
      item.quality += 1
    end
  end

  verify_name(item.name, item).call

  if item.quality > 0 
    if item.name == "NORMAL ITEM"
      item.quality -= 1
    end
    if item.name != 'Sulfuras, Hand of Ragnaros' and item.name != 'Backstage passes to a TAFKAL80ETC concert' and item.name != "Aged Brie" and item.sell_in < 0
      item.quality -= 1
    end
  end

  if item.name == 'Backstage passes to a TAFKAL80ETC concert' and item.name != "Aged Brie" and item.sell_in < 0
    item.quality = 0
  end
  if item.quality < 50 and item.name == "Aged Brie" and item.sell_in < 0
    item.quality += 1
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

