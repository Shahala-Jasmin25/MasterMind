# frozen_string_literal: true

require_relative 'display.rb'
require_relative 'computer_breaker.rb'

# Display module
class Game
  include Display

  def play
    puts display_instructions
    mode = fetch_game_mode
    mode == 1 ? code_maker : code_breaker
  end

  def fetch_game_mode
    input = gets.chomp.to_i
    return input if [1, 2].any?(input)

    puts warning_message('invalid_mode')
    fetch_game_mode
  end

  def code_maker
    breaker = ComputerBreaker.new
    breaker.break_the_code
  end

  def code_breaker
    puts 'BREAKER'
  end
end
