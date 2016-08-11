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

game = HangmanUI.new

game.welcome
game.start
game.play

while yes_no?("Would you like to play again ?")
	game.play	
end

puts ""
puts "Thanks for playing !"
