# frozen_string_literal: true

require_relative 'display.rb'
require_relative 'master_mind_logic.rb'

# Computer breaker class
class ComputerBreaker
  include Display
  include MasterMindLogic

  attr_accessor :maker_code, :turn_count, :guessed_codes, :master_digits,
                :total_number, :exact_count, :same_count

  def break_the_code
    puts message_from_computer('enter_the_code')
    fetch_code_from_player
    show_code(maker_code)
    puts turn_message('master_code')
    find_master_code
  end

  def find_master_code
    numbers = %w[1 2 3 4 5 6]
    options = numbers.shuffle
    @turn_count = 1
    @guessed_codes = []
    @master_digits = find_master_digits(options)
    crack_the_code
  end

  def find_master_digits(options, index = 0, guess = [])
    guess.pop(4 - total_number) unless turn_count == 1
    guess << options[index] until guess.count == 4
    computer_turn(guess)
    return guess if total_number == 4

    @turn_count += 1
    find_master_digits(options, index + 1, guess)
  end

  def computer_turn(guess)
    puts turn_message('computer_turn', turn_count)
    sleep(1)
    show_code(guess)
    compare(maker_code, guess)
    show_clues(exact_count, same_count)
    guess_arr = guess.clone
    @guessed_codes << [guess_arr, exact_count, same_count]
  end

  def crack_the_code
    set_combinations
    @guessed_codes.each { |code| compare_with_guesses(code) }
    continue_turns
  end

  def compare_with_guesses(code)
    run_compare(code[0], code[1], code[2])
  end

  def run_compare(guess, exact, same)
    @possible_combinations.each do |combo|
      compare(combo, guess)
      next if exact_count == exact && same_count == same

      @possible_combinations.reject! { |a| a == combo }
    end
  end

  def continue_turns
    until turn_count > 12
      computer_turn(@possible_combinations[0])
      if maker_code == @possible_combinations[0]
        game_over(true)
        break
      else
        run_compare(@possible_combinations[0], exact_count, same_count)
      end
      @turn_count += 1
    end
    game_over(false) if turn_count > 12
  end

  def set_combinations
    @possible_combinations = master_digits.permutation.to_a
    @possible_combinations.uniq!
  end

  def fetch_code_from_player
    input = gets.chomp
    if input.match(/^[1-6]{4}$/)
      @maker_code = input.split(//)
    else
      puts message_from_computer('invalid_master_code')
      fetch_code_from_player
    end
  end
end
