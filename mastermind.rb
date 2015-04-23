require 'byebug'

class Code
  attr_reader :colors
  attr_accessor :code

  def initialize(code)
    @code = code
  end

  def self.random
    @colors = ['R', 'G', 'B', 'Y', 'O', 'P']
    Code.new(@colors.sample(4))
  end

  def self.parse(move)
    Code.new(move)
  end

  def exact_matches(other_code)
    count = 0
    (0..3).each do |idx|
      if other_code.code[idx] == self.code[idx]
        count += 1
      end
    end
    count
  end

  def near_matches(other_code)
    count = 0
    4.times do |idx|
      4.times do |idx2|
        if idx != idx2 && self.code[idx] == other_code.code[idx2]
          count += 1
        end
      end
    end
    count
  end

end

class Game
  attr_reader :board, :secret_code, :moves, :guess

  def initialize
    @board = []
  end

  def start_game
    @moves = 1

    @secret_code = Code.random
    until won? || @moves == 13
      player_guess
      player_move
      #compare the guess
      @number_of_exact = @secret_code.exact_matches(@move)
      number_of_near = @secret_code.near_matches(@move)
      render
      @moves += 1
    end

    if won? && @moves < 13
      puts "You win!"
    else
      puts "You lose!"
    end
  end

  def player_guess
    puts "What is your move?"
    @guess = gets.chomp.split(' ')
  end

  def player_move
    @move = Code.parse(@guess)
  end

  def won?
    true if @number_of_exact == 4
  end

  def render
    print @guess
    puts "   You have #{@number_of_exact} exact matches and #{@number_of_near} near matches"
  end

end
