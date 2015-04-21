require 'matrix'

class Matrix
  def []=(x, y, value)
    @rows[x][y] = value
  end
end

class Board

  BOARD_HEIGHT = 3
  BOARD_WIDTH = 3

  def initialize
    # assuming only 3x3 boards exist
    # blank space = " ", marked by X = "X", marked by O = "O"
    @board = Matrix[[" ", " ", " "],
              [" ", " ", " "],
              [" ", " ", " "]]
  end

  def blank?( coord )
    @board.to_a[coord[0]][coord[1]] == " "
  end

  def apply_move( coord, player )
    @board[coord[0],coord[1]] = player
  end

  def display_board
    # assumes 2D board
    @board.to_a.length.times do |y|
      @board.row(0).to_a.length.times do |x|
        print @board.to_a[x][y]
        if x < @board.row(0).to_a.length - 1
          print '|'
        end
      end

      print "\n"

      if y < @board.to_a.length - 1
        ((@board.row(0).to_a.length*2)-1).times do |x|
          print '-'
        end
        print "\n"
      end

    end
  end

  def player_has_winning_move( player_value )
      @board.to_a.length.times do |x|
        if @board.row(x).select {|value| value == player_value }.length == 2
          if @board.row(x).index(" ")
            return [x,@board.row(x).to_a.index(" ")]
          end
        end
        if @board.column(x).select {|value| value == player_value }.length == 2
          if @board.column(x).to_a.index(" ")
            return [@board.column(x).to_a.index(" "),x]
          end
        end
      end
      return nil
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

    if coord = @board.player_has_winning_move( @player_type )
      @board.apply_move(coord, @player_type)
      puts "I think that player #{@player_type} has a winning move"
    else
      coord = random_move
      @board.apply_move(coord, @player_type)
      puts "Random move for #{@player_type}, coord #{coord}"
    end

    @board.display_board
    puts " "
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
