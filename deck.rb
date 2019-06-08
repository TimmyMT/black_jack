require_relative 'card.rb'

class Deck
  MASTIES = ['♥', '♦', '♣', '♠']
  CARDS = ['2', '3', '4', '5', '6',
           '7', '8', '9', '10',
           'J', 'Q', 'K', 'A']

  attr_accessor :cards, :given_cards

  def initialize
    @cards = []
    @given_cards = []
  end

  def generate
    MASTIES.each do |mastie|
      CARDS.each do |value|
        @cards << Card.new(value, mastie)
      end
    end
  end

end