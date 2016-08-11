require './lib/hangman_game'

class HangmanUI

	def initialize
		@game = HangmanGame.new
		@playing_board = Proc.new {
			system('clear')

			instructions
	
			3.times { indent }
			puts @game.feedback
			puts ""

			indent
			puts "Incorect letters already tried : #{@game.incorrect_letters}"

			indent
			puts "Guesses left : #{@game.guesses_left}"
			puts ""
		}
	end

	def welcome
		system('clear')

		puts "   --------------------------------------------------"
		puts "  |                                                  |"
		puts "  |   Welcome to the Hangman game written in Ruby !  |"
		puts "  |                                                  |"
		puts "  |                                                  |"
		puts "  |           Made for The Odin Project              |"
		puts "  |                                                  |"
		puts "   --------------------------------------------------"
	end

	def instructions
		puts "   --------------------------------------------------"
		puts "  |                                                  |"
		puts "  |   The aim of the game is to find a secret word   |"
		puts "  |          chosen by the other player.             |"
		puts "  |                                                  |"
		puts "  |    Each turn you  guess a letter and you will    |"
		puts "  |  get a feedback if the letter is in the word and |"
		puts "  |                in which position.                |"
		puts "  |                                                  |"
		puts "  |       You are allowed 10 incorect guesses.       |"
		puts "  |                    Good luck !                   |"
		puts "  |                                                  |"
		puts "   --------------------------------------------------"
		puts ""
	end

	def indent
		print "    "
	end

	def start
		puts ""
		2.times { indent }
		print "Press <enter> to start a new game "
		gets
	end

	def play

		@game = HangmanGame.new

		until @game.game_over

			@playing_board.call

			indent
			print "Guess a letter : "
			@game.new_guess
		end

		@playing_board.call

		if @game.game_over == "won"
			puts "Congratulations you won !"
		elsif @game.game_over == "lose"
			puts "You lose, no more guesses left..."
		end
		2.times { puts "" }
	end

end















