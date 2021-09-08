require_relative "board.rb"

class Game

  def initialize(board)
    @board = board
  end

  def play
    until @board.solved?
      @board.render
      pos = get_pos
      value = get_value
      until @board.valid_move?(pos, value)
        puts "That isn't a valid move"
        pos = get_pos
        value = get_value
      end 
      @board[pos] = value
    end
    "You win!"
  end
  
  def prompt_pos
    puts "Please enter a the number of the row and col from 0 to 8. ie. 0,0"
    pos = gets.chomp
    pos.split(",").map(&:to_i)
  end

  def prompt_value
    puts "Please enter a number to guess from 1 to 9 (0 will clear the tile) "
    guessed_value = gets.chomp.to_i
  end

  def get_pos
    pos = prompt_pos
    until valid_pos?(pos)
      # puts "That position isn't valid"
      pos = prompt_pos
    end
    pos 
  end

  def get_value
    value = prompt_value
    until valid_value?(value)
      # puts "That isn't a valid number"
      value = prompt_value
    end
    value
  end

  def valid_value?(guessed_value)
    guessed_value.is_a?(Integer) &&
    guessed_value.between?(0, 9)
  end

  def valid_pos?(pos)
    pos.is_a?(Array) &&
    pos.length == 2 &&
    pos.all?{ |num| num.between?(0, 8)}
  end


end

if $PROGRAM_NAME == __FILE__
  game = Game.new(Board.new("sudoku1.txt"))
  game.play
end