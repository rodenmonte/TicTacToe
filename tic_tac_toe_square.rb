class TicTacToeSquare
  EMPTY_SQUARE = ""
  X = "X"
  O = "O"

  attr_reader :letter

  def initialize()
    @letter = EMPTY_SQUARE
  end

  def empty?
    @letter == EMPTY_SQUARE
  end

  def set_contents(letter)
    raise "Square already set" unless empty?

    letter = letter
  end

  def set_x
    set_contents("X")
  end

  def set_o
    set_contents("O")
  end

  def to_s
    letter
  end

  def ==(other)
    letter == other.letter
  end
end
