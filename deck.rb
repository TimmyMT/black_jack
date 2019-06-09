require_relative 'card.rb'

class Deck
  SUITS = ['♥', '♦', '♣', '♠']
  CARDS = ['2', '3', '4', '5', '6',
           '7', '8', '9', '10',
           'J', 'Q', 'K', 'A']

  attr_accessor :cards, :given_cards

  def initialize
    @cards = []
  end

  def generate
    SUITS.each do |mastie|
      CARDS.each do |value|
        @cards << Card.new(value, mastie)
      end
    end
  end

end
