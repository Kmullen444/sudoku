require "colorize"

class Tile

  attr_reader :value
  
  def initialize(value)
    @value = value
    @given = value == 0? false : true
  end

  def value= (value)
    if given?
      puts "You can't change a number that is already set"
    else
      @value = value
    end
  end

  def color
    given?? :green : :red 
  end

  def given?
    @given
  end

  def test
    puts "This is blue".colorize(:blue)
  end

  def to_s
    @value == 0 ? " " : @value.to_s.colorize(color)
  end

end