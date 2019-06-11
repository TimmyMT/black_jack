require_relative 'card.rb'

class Deck
  attr_accessor :cards

  def initialize
    generate
  end

  def generate
    @cards = []
    Card::SUITS.each do |suit|
      Card::CARDS.each do |value|
        @cards << Card.new(value, suit)
      end
    end
  end
end
