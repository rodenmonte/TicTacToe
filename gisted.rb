#!/usr/bin/env ruby

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

class HumanClient < AbstractClient
  def get_square_id(board)
    print "?) "
    gets.chomp.to_i
  end
end

class RandomAiClient < AbstractClient
  def get_square_id(board)
    board.valid_moves.sample
  end
end

class TicTacToeSquare
  EMPTY_SQUARE = ""

  attr_reader :letter, :id

  def initialize(square_id = 0, letter = EMPTY_SQUARE)
    @id = square_id
    @letter = letter
  end

  def empty?
    @letter == EMPTY_SQUARE
  end

  def set_letter(letter)
    raise InvalidMoveError.new "Square already set" unless empty?

    @letter = letter
  end

  def to_s
    return id.to_s if letter == EMPTY_SQUARE
    letter
  end

  def ==(other)
    letter == other.letter
  end
end

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

class TicTacToeCliPlayer < AbstractTicTacToePlayer
  def prompt_game
    loop do
      puts "1) Play vs. AI"
      puts "2) Play vs. Human"
      puts "3) AI vs. AI"
      puts "4) Quit"
      print "?) "
      choice = gets.chomp.to_i
      if choice < 1 || choice > 4
        puts "Invalid choice, #{choice}, pick 1-4"
      elsif choice == 4
        exit(0)
      else
        play_game(choice)
      end
    end
  end

  def show_game_board(game)
    puts
    game.board.each_with_index do |row, index|
      separator = ' | '
      puts row.join(separator)
      unless game.board_size - 1 == index
        puts "-" * ((game.board_size - 1) * separator.size + game.board_size)
      end
    end
  end

  def tie_game
    puts "No legal moves. Draw!"
  end

  def handle_win(winner)
    puts "#{winner} wins!"
  end

  def pick_x_client(choice)
    case choice
    when 1, 2
      HumanClient.new('X')
    when 3
      RandomAiClient.new('X')
    end
  end

  def pick_o_client(choice)
    case choice
    when 2
      HumanClient.new('O')
    when 1, 3
      RandomAiClient.new('O')
    end
  end
end

# when executing directly...
if __FILE__ == $0
  TicTacToeCliPlayer.new.prompt_game
end

