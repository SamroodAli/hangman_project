require "byebug"
class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  def self.random_word
    DICTIONARY.sample
  end

  def initialize()
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length) {"_"}
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

  def get_matching_indices(string)
    arr = []
    @secret_word.each_char.with_index do |char, i|
      arr << i if char == string
    end
    arr
  end

  def fill_indices(char,arr)
    arr.each do |el|
     @guess_word[el] = char
    end
  end

  def try_guess(char)
    if self.already_attempted?(char)
      puts "That has already been attempted"
      return false
    else
      @attempted_chars << char
      if !@secret_word.include?(char)
        @remaining_incorrect_guesses -= 1
      else
        match_idx=self.get_matching_indices(char)
        self.fill_indices(char, match_idx)
      end
      return true
    end
  end

  def ask_user_for_guess
    puts "Enter a char"
    user_input = gets.chomp
    self.try_guess(user_input)
  end

  def win?
    if @guess_word.join == @secret_word
      puts "WIN"
      return true
    else
      return false
    end
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      puts "LOSE"
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
      return false
    end
  end

end
