require './lib/hangman_ui'

def yes_no?(question)
	puts question
	correct_answer = false
	until correct_answer
		answer = gets.chomp
		if answer == "y" || answer == "yes"
			return true
		elsif answer == "n" || answer == "no"
			return false
		else
			puts "Please only answer with (y)es or (n)o :"
		end
	end
end

@ui = HangmanUI.new

@ui.welcome
@ui.start

def new_game
	if yes_no?("Do you want to load a saved game?")
		@ui.load
		@ui.play(true)
	else
		@ui.play
	end
end

new_game

while yes_no?("Would you like to play again ?")
	new_game
end

puts ""
puts "Thanks for playing !"
2.times { puts "" }
