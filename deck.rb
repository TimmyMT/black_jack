require_relative 'card.rb'

class Deck
  SUITS = %w[♥ ♦ ♣ ♠].freeze
  CARDS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  attr_accessor :cards

  def initialize
    generate
  end

  def generate
    @cards = []
    SUITS.each do |suit|
      CARDS.each do |value|
        @cards << Card.new(value, suit)
      end
    end
  end
end
