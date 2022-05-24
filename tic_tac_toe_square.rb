require_relative 'invalid_move_error.rb'

class TicTacToeSquare
  EMPTY_SQUARE = ""

  attr_reader :letter, :id

  def initialize(square_id = 0, letter = EMPTY_SQUARE)
    @id = square_id
    @letter = letter
  end

  def empty?
    @letter == EMPTY_SQUARE
  end

  def set_letter(letter)
    raise InvalidMoveError.new "Square already set" unless empty?

    @letter = letter
  end

  def to_s
    return id.to_s if letter == EMPTY_SQUARE
    letter
  end

  def ==(other)
    letter == other.letter
  end
end

