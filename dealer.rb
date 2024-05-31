require_relative 'players_methods'

class Dealer
	include PlayersMethods

	attr_accessor :bank

	def initialize
		@name = "Dealer"
		@bank = 100
		@cards = []
		@points = 0
	end
end