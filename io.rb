class GuessingGame
  attr_reader :number

  def initialize
    @number = rand(1..100)
  end

  def over?(num)
    num == number
  end

  def high_low(num)
    if num < number
      puts "too low"
    else
      puts "too high"
    end
  end

  def prompt
    puts "What number am I thinking of?"
    Integer(gets)
  end

  def start
    loop do
      num = prompt
      break if over?(num)
      high_low(num)
    end
    puts "You Win!"
  end
end

new_game = GuessingGame.new
new_game.start
