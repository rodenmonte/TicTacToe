require_relative './abstract_client'

class RandomAiClient < AbstractClient
  def get_square_id(board)
    board.valid_moves.sample
  end
end

