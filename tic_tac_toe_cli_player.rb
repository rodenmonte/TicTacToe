#!/usr/bin/env ruby

require_relative './abstract_tic_tac_toe_player.rb'

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
      AiClient.new('X')
    end
  end

  def pick_o_client(choice)
    case choice
    when 2
      HumanClient.new('O')
    when 1, 3
      AiClient.new('O')
    end
  end
end

# when executing directly...
if __FILE__ == $0
  TicTacToeCliPlayer.new.prompt_game
end

