class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @prev.next = @next
    @next.prev = @prev
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head, @tail = Link.new, Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    each { |node| return node.val if node.key == key }
  end

  def include?(key)
    each do |node|
      if node.key == key
        return true
      else
        return false
      end
    end
  end

  def append(key, val)
    new_link, prev_link = Link.new(key, val), @tail.prev

    @tail.prev.next = new_link
    @tail.prev = new_link

    new_link.next = @tail
    new_link.prev = prev_link
  end

  def update(key, val)
    each { |node| node.val = val if node.key == key }
  end

  def remove(key)
    each { |node| node.remove if node.key == key }
  end

  def each
    next_link = @head.next
    until next_link == @tail
      yield(next_link)
      next_link = next_link.next
    end
  end

  #uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
