require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    self[key] << key unless include?(key)
    @count += 1 if include?(key)
    resize! if @count > num_buckets - 1
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    @count -= 1 if include?(key)
    self[key].delete(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    destination = @store.flatten
    @store = Array.new(num_buckets * 2) { [] }
    @count = 0
    destination.each { |el| insert(el) }
    @store
  end
end
