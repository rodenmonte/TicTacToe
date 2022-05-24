require_relative './abstract_client'

class HumanClient < AbstractClient
  def get_square_id(board)
    print "?) "
    gets.chomp.to_i
  end
end

