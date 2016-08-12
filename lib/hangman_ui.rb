require 'yaml'
require './lib/hangman_game'

class HangmanUI

	def initialize
		@game = nil
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

	def play(game_loaded = false)

		@game = HangmanGame.new unless game_loaded

		until @game.game_over

			@playing_board.call

			indent
			print "Guess a letter or type 'save' to save your game : "
			@game.new_guess
		end

		@playing_board.call

		if @game.game_over == "won"
			puts "Congratulations you won !"
		elsif @game.game_over == "lose"
			puts "You lose, no more guesses left..."
		elsif @game.game_over == "save"
			save
		end
		2.times { puts "" }
	end

	def save
		@game.save = false
		@game.dictionary = nil

		Dir.mkdir("saved_games") unless Dir.exists?("saved_games")
		filename = "saved_games/#{Time.now.day}_#{Time.now.month}_#{Time.now.year}_at_#{Time.now.hour}h#{Time.now.min}m#{Time.now.sec}.sav"
		
		File.open(filename,'w') do |file|
    	file.puts YAML::dump(@game)
  	end

		puts "Game saved !"
	end

	def load
		Dir.mkdir("saved_games") unless Dir.exists?("saved_games")
		
		save_files = Dir.entries("saved_games").select { |file| file[-4..-1] == ".sav"}

		if save_files == []
			puts "Sorry there are no saved games."
			print "Press <enter> to start a new game "
			gets
			@game = HangmanGame.new
		else
			system('clear')
			puts "List of the saved games :"
			save_files.each_with_index do |filename, index|
				@game = YAML::load(File.read "saved_games/#{save_files[index]}")
				puts "#{index + 1} :   #{@game.feedback}"
				puts "      Incorect letters already tried : #{@game.incorrect_letters}"
				puts "      Guesses left : #{@game.guesses_left}"
				puts "      Date and time of save : #{filename[0..-5]}"
				2.times { puts "" }
			end
			print "Choose the game you want to load :"
			
			correct_save = false
			until correct_save
				save_id = gets.chomp
				begin
					save_id = save_id.to_i - 1
					if save_id.between?(0, (save_files.size - 1))
						correct_save = true
					else
						puts "Use must enter a valid id between 1 and #{save_files.size - 1}"
					end
				rescue
					puts "Use must enter a valid id between 1 and #{save_files.size - 1}"
				end
			end

			@game = YAML::load(File.read "saved_games/#{save_files[save_id]}")
		end
	end

end















