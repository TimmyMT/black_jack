class Card
  SUITS = %w[♥ ♦ ♣ ♠].freeze
  CARDS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  attr_accessor :value, :suit

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def name
    @value + @suit
  end
end
