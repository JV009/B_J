require_relative 'deck'
require_relative 'user'
require_relative 'dealer'
require_relative 'players_methods'

class Interface
	attr_accessor :user, :dealer, :deck, :bank, :game_bank

	def start 
		puts "Welcome to Black Jack!"
		create_user
		create_dealer
		game
	end

	def create_user
		print "Write your name for the game:"
		name = gets.chomp
		@user = User.new(name)
	end

	def create_dealer
		@dealer = Dealer.new
	end

	def game
		create_deck
		reset
		start_user
		start_dealer
		place_bet(10)
		game_menu
	end

	def create_deck
		@deck = Deck.new()
	end

	def start_user
		card = []
		card << @deck.give_2_cards
		@user.cards << card[0][0] << card[0][1]
		@user.add_points(card[0][2])
		puts "#{@user.name}, you received two cards: #{@user.cards}."
		puts "Points scored #{@user.points}"
	end

 def start_dealer
    card = []
    card << @deck.give_2_cards
    @dealer.cards << card[0][0] << card[0][1]
    @dealer.add_points(card[0][2])
    puts "The Dealer received two cards."
  end

	def place_bet(bet)
		@user.bet_bank(bet)
		@dealer.bet_bank(bet)
		@game_bank = bet * 2
	end

	def game_menu
	 loop do
	 		open_cards if three_cards_have
      puts '1 - to skip a turn'
      puts '2 - to take one more card'
      puts '3 - to open cards'
      i = gets.chomp.to_i
      case i
      when 1
        dealer_turn
      when 2
        add_card
      when 3
        open_cards
      else 
      	puts "Select a number according to the list!"
      end
    end
  end

  def three_cards_have
  	if @user.cards.size == 3 && @dealer.cards.size == 3
  		true
  	else
  		false
  	end
  end

  def dealer_turn
  	if @dealer.cards.size == 3 || @dealer.points >= 17
  		puts "The Dealer missed the turn!"
  		game_menu
		else
			card = []
			card << @deck.give_card
			@dealer.cards << card[0][1]
			if card[0][1].include?("T") && (@dealer.points + card[0][0]) > 21
				@dealer.add_points(1)
			else
				@dealer.add_points(card[0][0])
			end
			puts "The Dealer got 1 card!"
		end
	end

	def add_card
		card = []
		card << @deck.give_card
		@user.cards << card[0][1]
		if card[0][1].include?("T") && (@user.points + card[0][0]) > 21
			@user.add_points(1)
		elsif card[0][1].include?("T") && (@user.points + card[0][0].include?("T")) > 21
			@user.add_points(-9)
		else
			@user.add_points(card[0][1])
		end
		puts "#{@user.name}, you got 1 card! \"#{card[0][1]}\""
		puts "Points scored #{@user.points}"
		open_cards if three_cards_have
		dealer_turn
	end

	def open_cards
		puts "Your cards:#{@user.cards}, scored #{@user.points} points."
		puts "The Dealer cards:#{@dealer.cards}, scored #{@dealer.points} points."
		if (@user.points > @dealer.points && @user.points <= 21) || (@user.points <= 21 && @dealer.points > 21)
			@user.bank += @game_bank
			@game_bank = 0
			puts "You won! You have #{@user.bank}$"
		elsif (@dealer.points > @user.points && @dealer.points <= 21) || (@dealer.points <= 21 && @user.points > 21)
			@dealer.bank += @game_bank
			@game_bank = 0
			puts "You lose! You have #{@user.bank}$"
		else @user.points == @dealer.points || (@user.points > 21 && @dealer.points > 21)
			@user.bank += @game_bank / 2
			@dealer.bank += @game_bank / 2
			@game_bank = 0
			puts "Draw! You have #{@user.bank}$"
		end
		next_game
	end

	def reset
		@user.clear_cards
		@dealer.clear_cards
		@user.points = 0
		@dealer.points = 0
	end

	def next_game
		loop do
			puts "#{@user.name}, you want to contine the game?"
			puts "1 - contine"
			puts "2 - stop"
			i = gets.chomp.to_i
			case i
			when 1
				game
			when 2
				exit
			else
				puts "Write 1 or 2!"
			end
		end
	end		
end