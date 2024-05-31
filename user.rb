require_relative 'players_methods'

class User
	include PlayersMethods

	attr_accessor :bank

	def initialize(name)
		@name = name
		@bank = 100
		@cards = []
		@points = 0
	end
end