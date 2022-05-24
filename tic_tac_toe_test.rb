require_relative './tester.rb'
require_relative './tic_tac_toe.rb'

include Tester
tests do
  test_case "New games have legal moves remaining" do
    assert_equal?(TicTacToe.new.no_legal_moves?, false)
  end

  test_case "New games aren't yet won" do
    assert_equal?(TicTacToe.new.winner_or_nil, nil)
  end

  test_case "Games can be printed" do
#    TicTacToe.new.print
  end
end

