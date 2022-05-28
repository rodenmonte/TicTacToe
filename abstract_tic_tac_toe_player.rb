require_relative './tic_tac_toe.rb'
require_relative './human_client.rb'
require_relative './random_ai_client.rb'

class AbstractTicTacToePlayer
  def play_game(choice)
    board = TicTacToe.new
    x_client = pick_x_client(choice)
    o_client = pick_o_client(choice)
    current_client = x_client

    until board.game_over? do
      show_game_board(board)

      begin
        current_client.move(board)
      rescue InvalidMoveError => _e
        puts "Invalid move, try again. Valid moves include: #{board.valid_moves}"
        next
      end

      current_client = current_client == x_client ? o_client : x_client
    end

    show_game_board(board)

    winner = board.winner_or_nil
    unless winner
      tie_game
    else
      handle_win(winner)
    end
  end

  def show_game_board
    raise NotImplementedError.new
  end

  def tie_game
    raise NotImplementedError.new
  end

  def handle_win(winner)
    raise NotImplementedError.new
  end

  def pick_x_client(choice)
    raise NotImplementedError.new
  end

  def pick_o_client(choice)
    raise NotImplementedError.new
  end
end
