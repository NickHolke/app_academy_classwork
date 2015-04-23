def initialize(guesser, checker)
     @mistakes = 0
    @guesser = guesser
    @checker = checker
  end

  def start_game

    @checker.pick_word

    until won? || @mistakes > 5
      p @mistakes

      display(@checker.compare(@guesser.guess))
    end

    if @mistakes > 5
      puts "You're hung"
    else
      puts "You win!"
    end
  end

  def display(stuff)
    p stuff
  end

  def won?
    @checker.won?
  end
end

class ComputerPlayer
  attr_reader :word, :dictionary

  def compare(guess)
    @mistakes += 1 unless @word.include?(@guesses.last)# will be undone if change made

    @word.each_with_index do |letter, idx|
      if guess == letter
        # @mistakes -= 1 unless @result.include?(letter)
        @result[idx] = letter
      end
    end
    @result
  end

  def read_dictionary_array
    @dictionary = []
    filename = 'dict.txt'
    File.open(filename).each do |line|
      dictionary << line.chomp
    end
    @dictionary
  end

  def pick_word
    read_dictionary_array
    @word = @dictionary.sample.split('')
    @dictionary = []
    @result = Array.new(@word.length, '_')
  end

  def guess
    ("a".."z").to_a.sample
  end
  
  def won?
    !@result.include?("_")
  end

end

class HumanPlayer

  def pick_word
    puts "Write your word down"
  end

  def guess
    puts "What is your guess?"
    gets.chomp
  end

end

computer = ComputerPlayer.new
human = HumanPlayer.new

Hangman.new(computer)
