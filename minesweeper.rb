class Board

attr_reader :rows

  def self.blank_grid
    Array.new(9) {Array.new(9)}
  end

  def initialize(rows = self.class.blank_grid)
    @rows = rows
    make_tiles
    place_mines
  end

  def []=(pos, mark)
    row, col = pos[0], pos[1]
    @rows[row][col] = mark
  end

  def [](pos)
    row, col = pos[0], pos[1]
    @rows[row][col]
  end

  def make_tiles
    @rows.each_with_index do |row, row_index|
      row.each_with_index do |col, col_index|
        @rows[row_index][col_index] = Tile.new([row_index, col_index], self)
      end
    end
  end

  def place_mines(num_mines = 10)
    bombs = []
    (0...9).each do |x|
      (0...9).each do |y|
        bombs << [x,y]
      end
    end
    selected = bombs.sample(num_mines)
    selected.each do |position|
      tile = @rows[position.first][position.last]
      tile.bombed = true
    end
  end

  def show_board
    output = @rows.map do |row|
      row.map do |col|
        print "[#{col.determine_display}]"
      end
      print "\n"
    end
  end

  def won?
  #return true
  #condition 1 = if bombed? && flagged?
  #condition 2 = if not bombed? then they should be revealed?
    @rows.each do |row|
      row.each do |ele|
        if !ele.bombed? && !ele.revealed?
          return false
        elsif ele.bombed? && !ele.flagged?
          return false
        end
      end
    end
    true
  end

  def lose?
    @rows.each do |row|
      row.each do |col|
        return true if col.revealed? && col.bombed?
      end
    end
    false
  end

  def run
    player = User.new(self)
    until won? || lose?
      show_board
      puts "Would you like to reveal or flag a position? (reveal/flag)"
      response = gets.chomp
      if response == "reveal"
        puts "Enter the position you would like to reveal. Ex: '1, 2'"
        position = gets.chomp.split(", ").map { |x| x.to_i }
        player.reveal(position)
      elsif response == "flag"
        puts "Enter the position you would like to flag. Ex: '1, 2'"
        position = gets.chomp.split(", ").map { |x| x.to_i }
        player.flag(position)
      end
    end
    if won?
      puts "YOU WIN MINESWEEPER!!!"
    elsif lose?
      puts "YOU HIT A MINE! YOU LOSE."
    end
  end
end

class Tile

  attr_reader :neighbors, :position, :bomb_count
  attr_accessor :flagged, :revealed, :bombed

  def initialize(position, board = nil)
    @board = board
    @position = position
    @flag = false
    @bombed = false
    @revealed = false
    @bomb_count = nil
  end

  def bombed?
    @bombed
  end

  def flagged?
    @flagged
  end

  def revealed?
    @revealed
  end

  def inspect
    "I am a tile and my object_id is #{object_id}"
  end

  def find_neighbors
      output = []
      (-1..1).each do |index1|
        (-1..1).each do |index2|
          next if index1 == 0 && index2 == 0
          output << [index1, index2]
        end
      end
      valid_moves = output.map do |move|
        [move.first + @position.first, move.last + @position.last]
      end
      neighbor_indices = valid_moves.reject do |neighbor|
        neighbor.first < 0 || neighbor.first > 8 ||
          neighbor.last < 0 || neighbor.last > 8
      end
      @neighbors = neighbor_indices.map do |index|
        @board.rows[index.first][index.last]
      end
  end

  def neighbor_bomb_count
    @bomb_count = 0
    @neighbors.each do |neighbor|
      if neighbor.bombed?
        @bomb_count += 1
      end
    end

    @bomb_count = nil if @bomb_count == 0
  end

  def determine_display
    if revealed?
      find_neighbors
      neighbor_bomb_count
      return @bomb_count || :_
    elsif flagged?
      return :F
    else
      return :*
    end
  end
end


class User

  attr_reader :tile

  def initialize(board)
    @board = board
  end

  def flag(position)
    find_tile(position).flagged = true
  end

  def unflag(position)
    find_tile(position).flagged = false
  end

  def reveal(position)
    find_tile(position).revealed = true
  end

  def find_tile(position)
    @tile = @board.rows[position.first][position.last]
  end

end

blah = Board.new
blah.run
