class Board

  def initialize
    # assuming only 3x3 boards exist
    # blank space = " ", marked by X = "X", marked by O = "O"
    @board = [[" ", " ", " "],
              [" ", " ", " "],
              [" ", " ", " "]]
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

end

board = Board.new
board.display_board
