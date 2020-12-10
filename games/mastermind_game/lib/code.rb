class Code
  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  def self.valid_pegs?(arrChars)
    arrChars.all? {|el| POSSIBLE_PEGS.include?(el.upcase) }
  end

  def initialize (arrChars)
    if Code::valid_pegs?(arrChars)
      @pegs=[]
      arrChars.each { |el|   @pegs << el.upcase}
    else
      raise
    end
  end
  def pegs 
    @pegs
  end
  
  def self.random(length)
    arr =[]
    randArray=[]
    POSSIBLE_PEGS.each_key { |el| arr << el}
    0...length.times {randArray << arr.sample}
    Code::new(randArray)
  end

  def self.from_string(string)
    Code::new(string.upcase.split(""))
  end
  def [](index)
    @pegs[index]
  end
  def length
    @pegs.length
  end

  def num_exact_matches(guess)
    (0...guess.length).count { |i| guess[i] == @pegs[i]}
  end
  def num_near_matches(guess)
    (0...guess.length).count { |i| @pegs.include?(guess[i])&& guess[i] != @pegs[i]}
  end
  def ==(guess)
    @pegs == guess.pegs
  end


  
end
