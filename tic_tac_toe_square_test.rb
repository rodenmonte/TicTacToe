require_relative './tester.rb'
require_relative './tic_tac_toe_square.rb'

include Tester

tests do
  test_case "TicTacToeSquare is initialized empty" do
    assert_equal?(TicTacToeSquare.new.empty?, true)
  end

  test_case "TicTacToeSquare#set_x changes string representation" do
    assert_equal?(TicTacToeSquare.new.set_x.to_s, TicTacToeSquare::X)
  end

  test_case "Empty TicTacToeSquares are equal" do
    assert_equal?(TicTacToeSquare.new, TicTacToeSquare.new)
  end

  test_case "TicTacToeSquares set to 'X' are equal" do
    assert_equal?(TicTacToeSquare.new.set_x, TicTacToeSquare.new.set_x)
  end

  test_case "TicTacToeSquares set to 'X' aren't equal to those set to 'O'" do
    assert_not_equal?(TicTacToeSquare.new.set_x, TicTacToeSquare.new.set_o)
  end

  test_case "TicTacToeSquares set to 'X' aren't equal to empties" do
    assert_not_equal?(TicTacToeSquare.new.set_x, TicTacToeSquare.new)
  end

  test_case "TicTacToeSquares set to 'X' aren't empty" do
    assert_equal?(TicTacToeSquare.new.set_x.empty?, false)
  end
end

