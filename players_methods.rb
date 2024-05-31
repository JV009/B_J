# frozen_string_literal: true

module PlayersMethods
  attr_accessor :name, :cards, :points

  def bet_bank(bet)
    @bank -= bet
  end

  def add_points(num)
    @points += num.to_i
  end

  def clear_cards
    @cards.clear
  end
end
