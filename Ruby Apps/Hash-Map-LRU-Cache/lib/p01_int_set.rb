class MaxIntSet
  attr_reader :store
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    if is_valid?(num) && validate!(num)
      @store[num] = true
    end
  end

  def remove(num)
    @store[num] = false if is_valid?(num)
  end

  def include?(num)

    @store[num] if is_valid?(num)
  end

  private

  def is_valid?(num)
    if !num.between?(0, @store.length)
      raise "Out of bounds"
    else
      true
    end
  end

  def validate!(num)
    !@store[num]
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num%20] << num
  end

  def remove(num)
    @store[num%20].delete(num)
  end

  def include?(num)
    @store[num%20].include?(num)
  end

  private

  def [](num)
    # @store[num%20]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_accessor :store, :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if include?(num)
      self.remove(num)
      self[num] << num
    else
      self[num] << num
    end
    @count+=1
    if @store.length <= @count
      resize!(@store)
    end
  end

  def remove(num)
    if self.include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    self.store[num % num_buckets]
  end

  def num_buckets
    self.store.length
  end

  def resize!(items)
    old_store = self.store
    self.count = 0
    self.store = Array.new(num_buckets * 2) {Array.new}
    items.flatten.each { |item| insert(item) }
  end
end
