class Board

  BOARD_HEIGHT = 3
  BOARD_WIDTH = 3

  def initialize
    # assuming only 3x3 boards exist
    # blank space = " ", marked by X = "X", marked by O = "O"
    @board = [[" ", " ", " "],
              [" ", " ", " "],
              [" ", " ", " "]]
  end

  def apply_move( coord, player )
    @board[coord[0]][coord[1]] = player
  end

  def display_board
    # assumes 2D board
    @board.length.times do |y|
      @board[0].length.times do |x|
        print @board[x][y]
        if x < @board[0].length - 1
          print '|'
        end
      end

      print "\n"

      if y < @board.length - 1
        ((@board[0].length*2)-1).times do |x|
          print '-'
        end
        print "\n"
      end

    end
  end

end

class Player

  def move( current_board )
    r = Random.new(1234)
    y = rand(0..Board::BOARD_HEIGHT-1)
    puts "y = #{y}"
    x = rand(0..Board::BOARD_WIDTH-1)
    puts "x = #{x}"
    return [x,y]
  end
end

board = Board.new
board.display_board

puts " "

player = Player.new
board.apply_move( player.move( board ), "X" )
board.display_board

puts " "
board.apply_move( player.move( board ), "0" )
board.display_board
puts " "
board.apply_move( player.move( board ), "X" )
board.display_board
puts " "
board.apply_move( player.move( board ), "0" )
board.display_board
