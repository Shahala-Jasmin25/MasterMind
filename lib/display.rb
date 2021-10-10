# frozen_string_literal: true
require 'colorize'
require_relative 'format.rb'

# Display module
module Display
  include Format

  def warning_message(message)
    {
      'invalid_mode' => 'Dude, select a valid mode. Either MAKER or BREAKER'.red
    }[message]
  end

  def message_from_computer(message)
    {
      'enter_the_code' => "\nHey Human, enter the 4 digit master code "\
                           'so I could crack it!',
      'invalid_master_code' => "\nGo read the rules. I said digits should be "\
                                'between 1 and 6 and not longer than 4.'.red,
      'won' => "\nI CRACKED YOUR CODE. LOOKS LIKE I AM THE GENIOUS HERE.".yellow,
      'lost' => "\nOkay I lost. I will let you win this time.".green
    }[message]
  end

  def turn_message(message, number = nil)
    {
      'master_code' => "is you master code \n\n",
      'computer_turn' => "\nComputer's turn No: #{number}\n"
    }[message]
  end

  def show_clues(exact, same)
    print '  Clues: '
    exact.times { print clue_colors('*') }
    same.times { print clue_colors('?') }
    puts ''
  end

  def clue_colors(clue)
    {
      '*' => "\e[91m\u25CF\e[0m ",
      '?' => "\e[37m\u25CB\e[0m "
    }[clue]
  end

  def show_code(array)
    array.each { |num| print color_codes(num) }
  end

  def display_instructions
    underline('ssssss')
    <<~HEREDOC


      #{underline('How to play Mastermind:')}

      This is a 1-player game against the computer.
      You can choose to be the code #{underline('maker')} or the code #{underline('breaker')}.

      There are six different number/color combinations:

      #{color_codes('1')}#{color_codes('2')}#{color_codes('3')}#{color_codes('4')}#{color_codes('5')}#{color_codes('6')}


      The code maker will choose four to create a 'master code'. For example,

      #{color_codes('1')}#{color_codes('3')}#{color_codes('4')}#{color_codes('1')}

      As you can see, there can be #{'more then one'.red} of the same number/color.
      In order to win, the code breaker needs to guess the 'master code' in 12 or less turns.


      #{underline('Clues:')}
      After each guess, there will be up to four clues to help crack the code.

       #{color_clues('*')}This clue means you have 1 correct number in the correct location.

       #{color_clues('?')}This clue means you have 1 correct number, but in the wrong location.


      #{underline('Clue Example:')}
      To continue the example, using the above 'master code' a guess of "1463" would produce 3 clues:

      #{color_codes('1')}#{color_codes('4')}#{color_codes('6')}#{color_codes('3')}  Clues: #{color_clues('*')}#{color_clues('?')}#{color_clues('?')}


      The guess had 1 correct number in the correct location and 2 correct numbers in a wrong location.

      #{underline("It's time to play!")}
      Would you like to be the code MAKER or code BREAKER?

      Press '1' to be the code MAKER
      Press '2' to be the code BREAKER
    HEREDOC
  end
end
