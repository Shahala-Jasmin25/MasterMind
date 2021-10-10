# frozen_string_literal: true

# module containing logic for master mind
module MasterMindLogic
  attr_accessor :exact_count, :same_count

  def compare(master_code, guessed_code)
    master = master_code.clone
    guess = guessed_code.clone
    @exact_count = check_exact_count(master, guess)
    @same_count = check_same_count(master, guess)
    @total_number = same_count + exact_count
  end

  def check_exact_count(master, guess)
    exact = 0
    master.each_with_index do |value, index|
      next unless value == guess[index]

      exact += 1
      master[index] = guess[index] = '*'
    end
    exact
  end

  def check_same_count(master, guess)
    same = 0
    master.each_with_index do |value, index|
      next unless value != '*' && guess.include?(value)

      same += 1
      master[index] = '?'
      ind = guess.find_index(value)
      guess[ind] = '?'
    end
    same
  end

  def game_over(won)
    if won
      puts message_from_computer('won')
    else
      puts message_from_computer('lost')
    end
  end
end
