require_relative './tester.rb'
require_relative './tic_tac_toe.rb'

include Tester
tests do
  winning_right_diag = TicTacToe.new([["X", "O", "X"],
                                      ["O", "X", "O"],
                                      ["O", "X", "X"]])

  winning_left_diag = TicTacToe.new([["O", "O", "X"],
                                      ["O", "X", "O"],
                                      ["X", "X", "X"]])

  winning_horizontal = TicTacToe.new([["", "X", "X"],
                                      ["", "X", "X"],
                                      ["O", "O", "O"]])

  winning_vertical = TicTacToe.new([["O", "O", "X"],
                                    ["O", "X", ""],
                                    ["O", "X", "X"]])

  test_case "New games have legal moves remaining" do
    assert_equal?(TicTacToe.new.no_legal_moves?, false)
  end

  test_case "New games aren't yet won" do
    assert_equal?(TicTacToe.new.winner_or_nil, nil)
  end

  test_case "A diagonal down and right 'X' winner is winning" do
    assert_equal?(winning_right_diag.winner_or_nil, "X")
  end

  test_case "A full board has no legal moves" do
    assert_equal?(winning_right_diag.no_legal_moves?, true)
  end

  test_case "A diagonal down and left 'X' winner is winning" do
    assert_equal?(winning_left_diag.winner_or_nil, "X")
  end

  test_case "A horizontal 'O' winner is winning" do
    assert_equal?(winning_horizontal.winner_or_nil, "O")
  end

  test_case "A vertical 'O' winner is winning" do
    assert_equal?(winning_vertical.winner_or_nil, "O")
  end
end

