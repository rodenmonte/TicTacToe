require_relative './tester.rb'
require_relative './tic_tac_toe_square.rb'

include Tester

tests do
  empty_square1 = TicTacToeSquare.new
  empty_square2 = TicTacToeSquare.new
  x_square1 = TicTacToeSquare.new.set_letter('X')
  x_square2 = TicTacToeSquare.new.set_letter('X')
  o_square1 = TicTacToeSquare.new.set_letter('O')

  test_case "TicTacToeSquare is initialized empty" do
    assert_equal?(empty_square1.empty?, true)
  end

  test_case "TicTacToeSquare#set_x changes string representation" do
    assert_equal?(x_square1.to_s, 'X')
  end

  test_case "Empty TicTacToeSquares are equal" do
    assert_equal?(empty_square1, empty_square2)
  end

  test_case "TicTacToeSquares set to 'X' are equal" do
    assert_equal?(x_square1, x_square2)
  end

  test_case "TicTacToeSquares set to 'X' aren't equal to those set to 'O'" do
    assert_not_equal?(x_square1, o_square1)
  end

  test_case "TicTacToeSquares set to 'X' aren't equal to empties" do
    assert_not_equal?(x_square1, empty_square1)
  end

  test_case "TicTacToeSquares set to 'X' aren't empty" do
    assert_equal?(x_square1.empty?, false)
  end
end

