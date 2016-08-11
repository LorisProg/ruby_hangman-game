#require 'pry'

class HangmanGame

	attr_accessor :dictionary, :secret_word, :guesses_left, :all_guesses, :current_guess  ## for the tests

	def initialize
#		binding.pry
		@dictionary = (File.read "5desk.txt").split("\r\n")
		@secret_word = select_secret_word(@dictionary)
		@guesses_left = 10
		@current_guess = ""
		@all_guesses = []
	end

	def select_secret_word(dictionary)
		word = ""
		word = dictionary[rand(0..(dictionary.length))] until word.length.between?(5, 12)
		word
	end

	def new_guess
		valid_guess = false

		until valid_guess
			guess = gets.chomp

			if guess.downcase.match(/[a-z]/) && guess.size == 1
				if @all_guesses.include?(guess)
					puts "You already used tried this letter, please try another one"
				else
					valid_guess = true
				end
			else
				puts "Please only enter one letter"
			end
		end

		@current_guess = guess
		@all_guesses << guess
		guesses_left_refresh
	end

	def feedback(guess = @all_guesses)

		return @secret_word.split("").join(" ") if game_over

		correct_letters = @secret_word.split("") & guess

		feedback = @secret_word.split("").map do |letter|
			letter = "_" if !correct_letters.include?(letter)
			letter
		end

		feedback.join(" ")
	end

	def incorrect_letters
		letters_played = @all_guesses.join.split("").uniq
		incorrect_letters = letters_played - @secret_word.split("")
		incorrect_letters.join(", ")
	end

	def game_over
		if (@secret_word.split("") & @all_guesses).size == @secret_word.split("").uniq.size
			return "won"
		elsif @guesses_left == 0
			return "lose"
		end
		false
	end

	def guesses_left_refresh
		@guesses_left -= 1 if !@secret_word.split("").include?(@current_guess)
	end

end