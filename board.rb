require_relative "tile.rb"
require "colorize"
require "byebug"

class Board
 
  def self.from_file(file)
    grid = File.readlines(file).map do |line|
      line.chomp.split('').map { |value| Tile.new(value.to_i)}
    end
  end

  attr_reader :grid

  def initialize(file)
    @grid = Board.from_file(file)
  end

  def size
    @grid.length
  end
  

  def cols
    grid.transpose
  end

  def sqrs
    squares
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    tile = @grid[row][col]
    tile.value = value
  end

  def position(pos,value)
    row, col = pos
    @grid[row][col].value = value
  end

  def render
    system("clear")
    boarder = "+-----+-----+-----+"

    (0...size).each do |i|
      puts boarder if i % 3 == 0

      (0...size).each do |j|
        print j % 3 == 0? "|" : " "
        print @grid[i][j].to_s
      end
      puts "|"
    end
    puts boarder
  end

  def square_selector(idx)
    row, col = idx

    case row
    when 0..2
      case col
      when 0..2
        sqrs[0]
      when 3..5
        sqrs[1]
      when 4..8
        sqrs[2]
      end
    when 3..5
      case col
      when 0..2
        sqrs[3]
      when 3..5
        sqrs[4]
      when 4..8
        sqrs[5]
      end
    when 6..8
      case col
      when 0..2
        sqrs[6]
      when 3..5
        sqrs[7]
      when 4..8
        sqrs[8]
      end
    end
    
  end

  def valid_square?(idx, value)
    squares_idx = square_selector(idx)
    squares_idx.none? { |tile| tile.value == value}
  end

  def valid_row?(row, value)
    @grid[row].none? { |tile| tile.value == value}
  end 

  def valid_col?(idx, value)
    cols[idx].none? { |tile| tile.value == value}
  end

  def valid_move?(idx, value)
    row, col = idx
    valid_row?(row,value) &&
      valid_col?(col, value) &&
      valid_square?(idx,value)
  end


  def square(idx)
    tiles = []
    x = (idx / 3) * 3
    y = (idx % 3) * 3

    (x...x + 3).each do |i|
      (y...y + 3).each do |j|
        tiles << @grid[i][j]
      end
    end
    tiles
  end

  def squares
    (0...size).map { |i| square(i)}
  end

  def solved?
    @grid.all? { |row| solved_set?(row)} &&
      cols.all? { |col| solved_set?(col)} &&
      squares.all? { |square| solved_set?(square)}
  end

  def solved_set?(tiles)
    nums = tiles.map { |tile| tile.value}
    nums.sort == (1..9).to_a
  end

end