class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  def self.random_word
    return DICTIONARY.sample
  end
  
  def initialize
    @secret_word = Hangman::random_word
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end
  
  def guess_word
    @guess_word
  end
  def attempted_chars
    @attempted_chars
  end
  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end
  def already_attempted?(char)
    @attempted_chars.include?(char)
  end
  
  def get_matching_indices(char)
    arr=[]
    @secret_word.each_char.with_index do |c,i|
      arr << i if c==char
    end
    arr
  end

  def fill_indices(char,arr)
    arr.each {|el| @guess_word[el] = char}
  end

  def try_guess(char)
    if self.already_attempted?(char)
      puts "that has already been attempted" 
      return false
    end
    idxArr = self.get_matching_indices(char)
    self.fill_indices(char,idxArr)
    @attempted_chars << char
    @remaining_incorrect_guesses-=1 if idxArr.empty?
    true
  end

  def ask_user_for_guess
    p "Enter a char:"
    char = gets.chomp
    trial = self.try_guess(char) 
  end

  def win?
    if @guess_word.join("")  == @secret_word
      puts "WIN"
      return true
    else
      return false
    end
  end

  def lose?
    if @remaining_incorrect_guesses ==0
      p "LOSE"
      return true
    else
      return false
    end
  end

  def game_over?
    if self.win? || self.lose?
      puts @secret_word
      return true
    else
      false
    end

  end


end
