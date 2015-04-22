
class Board
  attr_accessor :board
  attr_accessor :winner

  def initialize
    @board = Array.new(3, Array.new(3, " "))
    @winner = nil
  end


  def rows
    board.each do |row|
      r = win_helper(row)
      if r != nil
        return r
      end
    end
    nil
  end
  def columns
    (0..2).each do |i|
      column = []
      board.each do |el|
        column << el[i]
      end
      r = win_helper(column)
      if r != nil
        return r
      end
    end
    nil
  end
  def diag
    down = [board[0][0], board[1][1], board[2][2]]
    up = [board[2][0], board[1][1], board[2][0]]
    r = win_helper(down)
    if r == nil
      r = win_helper(up)
    end
    r
  end
  def win_helper(arr)
    if arr.all? { |value| value == :x}
      return :x
    elsif arr.all? { |value| value == :o}
      return :o
    else
      return nil
    end
  end

  def won?
    [columns, diag, rows].each do |checker|
      if checker != nil
        winner = checker.to_s
        return true
      end
    end
    false
  end


  def place_mark(row, column, mark)
    p board[row][column]
    board[row][column] = mark
    p board[row][column]
    p board
  end

  def valid_move?(row, column)
    if board[pos[0]][pos[1]] == nil
      true
    else
      false
    end
  end

  def prompt
    puts "which row?"
    row = gets.chomp.to_i
    puts "which column?"
    column = gets.chomp.to_i
    [row, column]
  end

  def render
    p board
  end

end

class Game
  def initialize(human, cpu)
    @human = human
    @cpu = cpu
    @board = Board.new
  end

  def play
    i = 0
    until @board.won?
      if i.odd?
        # is cpu
        mark = :o
        row = cpu.pick_pos
      else
        # is human
        pos = @board.prompt
        row = pos[0]
        column = pos[1]
        mark = :x
      end
      @board.place_mark(row, column, mark)
      i += 1
    end
    puts "#{@board.winner} wins!"
  end
end



class HumanPlayer
end

class ComputerPlayer
  def pick_pos
    pos = []
    2.times do
      pos << rand(0..2)
    end
  end
end


man = HumanPlayer.new
ai = ComputerPlayer.new
this_game = Game.new(man, ai)
this_game.play

# test_board = Board.new
# (0..2).each do |i|
#   test_board.board[i][0] = :x
# end
#
# p test_board.won?
