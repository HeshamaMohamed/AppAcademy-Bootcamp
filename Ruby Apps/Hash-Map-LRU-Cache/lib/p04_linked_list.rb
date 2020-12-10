class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

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
    self.prev.next = self.next if self.prev
    self.next.prev = self.prev if self.next
    self.next = nil
    self.prev = nil
    self
  end
end

class LinkedList
  attr_accessor :head, :tail
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    if !self.empty?
      self.head.next
    else
      nil
    end
  end

  def last
    if !self.empty?
      self.tail.prev
    else
      nil
    end
  end

  def empty?
    self.head.next == self.tail
  end

  def get(key)
    each { |node| return node.val if node.key == key} 
  end

  def include?(key)
    each { |node| return true if node.key == key} 
    false
  end

  def append(key, val)
    pNew = Node.new(key, val)
    self.tail.prev.next = pNew
    pNew.prev = self.tail.prev
    pNew.next = self.tail
    self.tail.prev = pNew
    pNew
  end

  def update(key, val)
    each { |node| node.val = val if node.key == key} 
  end

  def remove(key)
    each do |node|
      if node.key == key
        node.remove
        return node.val
      end
    end
    nil
  end

  def each
    pTrav = self.head.next
    while pTrav != self.tail
      yield pTrav
      pTrav = pTrav.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
