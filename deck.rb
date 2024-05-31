# frozen_string_literal: true

class Deck
  attr_accessor :take_cards
  attr_reader :deck

  def initialize
    @deck = {
      '2♣' => 2, '2♥' => 2, '2♠' => 2, '2♦' => 2,
      '3♣' => 3, '3♥' => 3, '3♠' => 3, '3♦' => 3,
      '4♣' => 4, '4♥' => 4, '4♠' => 4, '4♦' => 4,
      '5♣' => 5, '5♥' => 5, '5♠' => 5, '5♦' => 5,
      '6♣' => 6, '6♥' => 6, '6♠' => 6, '6♦' => 6,
      '7♣' => 7, '7♥' => 7, '7♠' => 7, '7♦' => 7,
      '8♣' => 8, '8♥' => 8, '8♠' => 8, '8♦' => 8,
      '9♣' => 9, '9♥' => 9, '9♠' => 9, '9♦' => 9,
      '10♣' => 10, '10♥' => 10, '10♠' => 10, '10♦' => 10,
      'K♣' => 10, 'K♥' => 10, 'K♠' => 10, 'K♦' => 10,
      'T♣' => 11, 'T♥' => 11, 'T♠' => 11, 'T♦' => 11,
      'J♣' => 10, 'J♥' => 10, 'J♠' => 10, 'J♦' => 10,
      'Q♣' => 10, 'Q♥' => 10, 'Q♠' => 10, 'Q♦' => 10
    }
  end

  def give_2_cards
    i = 0
    key = ''
    points = 0
    result = []
    loop do
      keys = @deck.keys
      key = keys[rand(keys.size)]
      points += @deck[key]
      @deck.delete(key)
      result << key
      i += 1
      break if i == 2
    end
    result << points
  end

  def give_card
    result = []
    keys = @deck.keys
    key = keys[rand(keys.size)]
    result << @deck[key]
    @deck.delete(key)
    result << key
  end
end
