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

  def full?
    @board.each do |space|
      if space == " "
        return false
      end
    end

    return true
  end

  def open_wins_at_coord( coord, opponent_value )
    open_wins = 0
    # puts "#Coord: [#{coord[0]}, #{coord[1]}]"
    open_wins += 1 unless @board.row(coord[0]).to_a.index( opponent_value )
    open_wins += 1 unless @board.column(coord[1]).to_a.index( opponent_value )

    diagonal_coords = [[0,0],[1,1],[2,2]]
    diagonal_coords_mirror = [[0,2],[1,1],[2,0]]

    remaining_diagonal_coord = diagonal_coords.reject {|x| x == coord}
    remaining_diagonal_coord_mirror = diagonal_coords_mirror.reject {|x| x == coord}

    if remaining_diagonal_coord.length == 2
        open_wins += 1 unless @board[remaining_diagonal_coord[0][0],remaining_diagonal_coord[0][1]] == opponent_value ||
          @board[remaining_diagonal_coord[1][0],remaining_diagonal_coord[1][1]] == opponent_value
    end

    if remaining_diagonal_coord_mirror == 2
      open_wins += 1 unless @board[remaining_diagonal_coord_mirror[0][0],remaining_diagonal_coord_mirror[0][1]] == opponent_value ||
        @board[remaining_diagonal_coord_mirror[1][0],remaining_diagonal_coord_mirror[1][1]] == opponent_value
    end
    # puts "Open wins at #{coord}: #{open_wins}"

    return open_wins
  end

  def take_best_space( player_type, opponent_type )
    best_coord = [-1,-1]
    max_open = 0

    @board.row_count.times do |y|
      @board.column_count.times do |x|
        temp = @board[x,y] == " " ? open_wins_at_coord( [x,y], opponent_type ) : 0
        if temp > max_open
          max_open = temp
          best_coord = [x,y]
        end
      end
    end

    return best_coord
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
          if @board.row(x).to_a.index(" ")
            return [x,@board.row(x).to_a.index(" ")]
          end
        end
        if @board.column(x).select {|value| value == player_value }.length == 2
          if @board.column(x).to_a.index(" ")
            return [@board.column(x).to_a.index(" "),x]
          end
        end
      end
      #FIXME -- assuming 3x3 board for now
      diagonal = [@board[0,0],@board[1,1],@board[2,2]]
      if diagonal.select {|value| value == player_value }.length == 2
        if diagonal.index(" ")
          return [diagonal.index(" "),diagonal.index(" ")]
        end
      end

      diagonal = [@board[0,2],@board[1,1],@board[2,0]]
      if diagonal.select {|value| value == player_value }.length == 2
        if diagonal.index(" ")
          return [diagonal.index(" "), 2 - diagonal.index(" ")]
        end
      end

      return nil
  end

end

class Player

  def initialize( board, player_type, opponent_type )
    @board = board
    @player_type = player_type # "X" or "O"
    @opponent_type = opponent_type # "X" or "O"
    @winner = false
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

    #if there is a winning move, take it
    if coord = @board.player_has_winning_move( @player_type )
      @board.apply_move(coord, @player_type)
      puts "I think that player #{@player_type} has a winning move"
      @winner = true
    #if your opponent is about to win, block that space
    elsif coord = @board.player_has_winning_move( @opponent_type )
      @board.apply_move(coord,@player_type)
      puts "Block player #{@player_type}'s opponent"
    #otherwise, take the best space available
    elsif coord = @board.take_best_space( @player_type, @opponent_type )
      @board.apply_move(coord, @player_type)
      puts "This is the best space available"
    else
      coord = random_move
      @board.apply_move(coord, @player_type)
      puts "Random move for #{@player_type}, coord #{coord}"
    end

    @board.display_board
    puts " "

    return @winner
  end
end

board = Board.new
board.display_board

puts " "

player_x = Player.new(board, "X", "O")
player_o = Player.new(board, "O", "X")
x_goes = true
winner = false
tie = false

until winner || tie
  winner = x_goes ? player_x.move : player_o.move
  tie = board.full?
  x_goes = !x_goes
end
