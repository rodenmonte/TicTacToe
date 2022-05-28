require_relative './tic_tac_toe_square.rb'
require_relative './invalid_move_error.rb'

class TicTacToe
  attr_reader :board, :board_size

  # For ease of testing, board_param can be a multidimensional array of "X", "O", and ""
  def initialize(board_param = [])
    @board = board_param.clone
    @board_size = board_param.empty? ? 3 : board_param.size
    unless board_param.empty?
      raise ArgumentError.new("Invalid board, must be square") if board.size != board.first.size
    end

    square_id = 0
    1.upto(@board_size).map do |row_idx|
      if board_param.empty?
        @board.push([])
      end

      1.upto(@board_size).map do |col_idx|
        letter = board_param.empty? ? TicTacToeSquare::EMPTY_SQUARE : @board[row_idx - 1][col_idx - 1]
        @board[row_idx - 1][col_idx - 1] = TicTacToeSquare.new(square_id += 1, letter)
      end
    end
  end

  def valid_moves
    board.flatten.select(&:empty?).map(&:id)
  end

  def move(square_id, letter)
    begin
      board.flatten.find { |sq| sq.id == square_id }.set_letter(letter)
    rescue NoMethodError => _e
      raise InvalidMoveError.new
    end
  end

  def game_over?
    winner_or_nil || no_legal_moves?
  end

  def no_legal_moves?
    valid_moves.empty?
  end

  # Returns the letter of the winner, or nil if none.
  def winner_or_nil
    # Check horizontally
    board.each do |row|
      res = check_row_for_winner_or_nil(row)
      return res if res
    end

    # Check verticals by checking transposed rows
    board.transpose.each do |row|
      res = check_row_for_winner_or_nil(row)
      return res if res
    end

    # Check diagonals
    left_diag = []
    right_diag = []
    board.each_with_index do |row, row_idx|
      row.each_with_index do |el, col_idx|
        if col_idx == row_idx
          left_diag.push(el)
        end

        if row_idx + col_idx + 1 == board_size
          right_diag.push(el)
        end
      end
    end
    check_row_for_winner_or_nil(left_diag) || check_row_for_winner_or_nil(right_diag)
  end

  def check_row_for_winner_or_nil(row)
    elements = row.map(&:letter).uniq
    return elements.first if elements.size == 1 && elements.first != TicTacToeSquare::EMPTY_SQUARE
  end
end

