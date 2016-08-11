require "rspec"
require_relative "../lib/hangman_game"

describe HangmanGame do

	before do
		@new_game = HangmanGame.new
	end
	
	context "When a new party is started" do
		
			it "the script should load the dictionary 5desk.txt" do
				expect(@new_game.dictionary).to eql((File.read "5desk.txt").split("\r\n"))
			end

			it "selects a word between 5 and 12 caracter long for the secret word" do
				expect(@new_game.secret_word.length).to be_between(5, 12).inclusive
			end

			it "this word should be random" do
				expect(HangmanGame.new.secret_word).not_to eq(@new_game.secret_word)
			end
	end

	context "during the game" do

		context "the counter of guesses left should decrease for every incorrect guess. Initial number : 10" do
			
			it "ex: secret_word = 'salami' , guess = 's' , counter should be 10" do
				@new_game.secret_word = "salami"
				@new_game.current_guess = "s"
				@new_game.guesses_left_refresh

				expect(@new_game.guesses_left).to eql(10)
			end

			it "ex: secret_word = 'salami' , guess = 'p' , counter should be 9" do
				@new_game.secret_word = "salami"
				@new_game.current_guess = "p"
				@new_game.guesses_left_refresh

				expect(@new_game.guesses_left).to eql(9)
			end

		end


		context "a feedback should display the incorrect letters already played (ex: secret_word = 'philosophy')" do

			it "after first guess = 'carrot' , incorrect letters should be 'c, a, r, t'" do
				@new_game.secret_word = "philosophy"
				@new_game.all_guesses = ["carrot"]
				expect(@new_game.incorrect_letters).to eql("c, a, r, t")
			end

			it "after second guess = 'hypster' , incorrect letters should be 'c, a, r, t, e'" do
				@new_game.secret_word = "philosophy"
				@new_game.all_guesses = ["carrot", "hypster"]
				expect(@new_game.incorrect_letters).to eql("c, a, r, t, e")
			end

			it "after third guess = 'madagascar' , incorrect letters should be 'c, a, r, t, e, m, d, g'" do
				@new_game.secret_word = "philosophy"
				@new_game.all_guesses = ["carrot", "hypster", "madagascar"]
				expect(@new_game.incorrect_letters).to eql("c, a, r, t, e, m, d, g")
			end

			it "after correct guess = 'philosophy' , incorrect letters should be 'c, a, r, t, e, m, d, g'" do
				@new_game.secret_word = "philosophy"
				@new_game.all_guesses = ["carrot", "hypster", "madagascar", "philosophy"]
				expect(@new_game.incorrect_letters).to eql("c, a, r, t, e, m, d, g")
			end

			it "after first guess = 'c' , incorrect letters should be 'c'" do
				@new_game.secret_word = "philosophy"
				@new_game.all_guesses = ["c"]
				expect(@new_game.incorrect_letters).to eql("c")
			end

			it "after second guess = 'h' , incorrect letters should be 'c'" do
				@new_game.secret_word = "philosophy"
				@new_game.all_guesses = ["c", "h"]
				expect(@new_game.incorrect_letters).to eql("c")
			end

			it "after third guess = 'm' , incorrect letters should be 'c, m'" do
				@new_game.secret_word = "philosophy"
				@new_game.all_guesses = ["c", "h", "m"]
				expect(@new_game.incorrect_letters).to eql("c, m")
			end

		end

		context "a feedback should display if the guess is the correct and its position" do

			it "ex : secret_word = 'carrot' , guess = 'r' , feedback sould be = '_ _ r r _ _'" do
				@new_game.secret_word = "carrot"
				expect(@new_game.feedback(["r"])).to eql("_ _ r r _ _")
			end

			it "ex : secret_word = 'madagascar' , guess = 'a' , feedback sould be = '_ a _ a _ a _ _ a _'" do
				@new_game.secret_word = "madagascar"
				expect(@new_game.feedback(["a"])).to eql("_ a _ a _ a _ _ a _")
			end

			it "ex : secret_word = 'madagascar' , guess = 'p' , feedback sould be = '_ _ _ _ _ _ _ _ _ _'" do
				@new_game.secret_word = "madagascar"
				expect(@new_game.feedback(["p"])).to eql("_ _ _ _ _ _ _ _ _ _")
			end

		end

		context "previous correct guesses should stay visible for next feedback" do

			it "ex : secret_word = 'philosophy' , first guess 'p' second guess 'l', feedback should be 'p _ _ l _ _ _ p _ _'" do
				@new_game.secret_word = "philosophy"
				@new_game.all_guesses = ["p", "l"]
				expect(@new_game.feedback(@new_game.all_guesses)).to eql("p _ _ l _ _ _ p _ _")
			end

		end

	end

	context "end of game" do

		context "game over if player found all correct letters" do
			
			it "ex : secret_word = 'philosophy' , all_guesses = ['p', 'l', 'a', 'i', 'e', 'h', 'o', 's', 'y'] , it should be game over" do
				@new_game.secret_word = "philosophy"
				@new_game.all_guesses = ['p', 'l', 'a', 'i', 'e', 'h', 'o', 's', 'y']
				
				expect(@new_game.game_over).to be_truthy
			end
		end

		context "not game over if guesses_left > 0 and not all letters found" do

			it "ex : secret_word = 'philosophy' , all_guesses = ['p', 'l', 'a', 'i', 'e'] , guesses_left = 2 , should not be game over" do
				@new_game.secret_word = "philosophy"
				@new_game.all_guesses = ['p', 'l', 'a', 'i', 'e']
				@new_game.guesses_left = 2
				
				expect(@new_game.game_over).to be false
			end
		end

		context "game over if guesses_left == 0" do

			it "ex : secret_word = 'philosophy' , all_guesses = ['p', 'l', 'a', 'i', 'e'] , guesses_left = 0 , should be game over" do
				@new_game.secret_word = "philosophy"
				@new_game.all_guesses = ['p', 'l', 'a', 'i', 'e']
				@new_game.guesses_left = 0
				
				expect(@new_game.game_over).to be_truthy
			end
		end


	end

end