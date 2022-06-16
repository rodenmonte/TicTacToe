require 'stringio'
require_relative './tester.rb'
require_relative './tic_tac_toe_cli_player.rb'

include Tester
tests do
  test_case "An AI vs. AI game can complete without errors" do
    begin
      stdout = $stdout
      $stdout = StringIO.new
      TicTacToeCliPlayer.new.play_game(3)
    ensure
      $stdout = stdout
    end
  end
end

