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

  def blank?( coord )
    @board[coord[0]][coord[1]] == " "
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

  def initialize( board, player_type )
    @board = board
    @player_type = player_type # "X" or "O"
  end

  def random_move( )
    while true
      y = rand(0..Board::BOARD_HEIGHT-1)
      x = rand(0..Board::BOARD_WIDTH-1)
      if @board.blank?([x,y])
        return [x,y]
      end
    end
  end

  def opponents_move( coord, opponent_player_type )
    @board.apply_move(coord,opponent_player_type)
  end

  def move()

    coord = random_move
    @board.apply_move(coord, @player_type)
    @board.display_board
    puts " "
    return coord
  end
end

board = Board.new
board.display_board

puts " "

player_x = Player.new(board, "X")
player_o = Player.new(board, "O")
player_x.move
player_o.move
player_x.move
player_o.move
