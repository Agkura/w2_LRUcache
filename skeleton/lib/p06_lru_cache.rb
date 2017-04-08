require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_link!(@map[key])
    else
      calc!(key)
    end

    if count > @max
      @map.delete(@store.first.next)
    end
    @store.get(key)
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    @map.set(key, @store.append(key, @prc.call(key)))
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(link)
    @map.set(link)
    # suggested helper method; move a link to the end of the list
  end

  def eject!
  end
end
