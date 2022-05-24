class AbstractClient
  attr_reader :letter

  def initialize(letter)
    @letter = letter
  end

  def move(board)
    square_id = get_square_id(board)
    board.move(square_id, letter)
  end

  def get_square_id(board)
    raise NotImplementedError.new
  end
end

