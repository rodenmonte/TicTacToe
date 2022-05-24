require_relative './tic_tac_toe_square.rb'

class TicTacToe
  def initialize(board_size = 3)
    @board = []
    1.upto(board_size).map do |row|
      @board.push([])
      1.upto(board_size).map do |col|
        @board[row - 1][col - 1] = TicTacToeSquare.new
      end
    end
  end

  def print
    board.each_with_index do |row, index|
      separator = ' | '
      puts board[row].join(separator)
      unless board_size - 1 == index
        puts ((board_size - 1) * separator + board_size) * "-"
      end
    end
  end

  def game_over?
    return true if winner_or_nil || no_legal_moves?
  end

  def no_legal_moves?
    return true if @board.flatten.count(&:empty?) == 0
    false
  end

  # Returns the letter of the winner, or nil if none.
  def winner_or_nil
    # Check horizontally
    
    # Check verticals
    
    # Check diagonals

    nil
  end
end

