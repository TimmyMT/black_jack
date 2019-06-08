class Deck
  MASTIES = ['♥', '♦', '♣', '♠']
  CARDS = ['2', '3', '4', '5', '6',
           '7', '8', '9', '10',
           'J', 'Q', 'K', 'A']

  attr_reader :card
  @@cards = []

  def initialize(card, mastie)
    @card = "#{card}#{mastie}"
  end

  def self.cards
    @@cards
  end

  def self.generate
    @@cards.clear
    MASTIES.each do |m|
      CARDS.each do |c|
        @@cards << Deck.new(c, m)
      end
    end
    @@cards.count
  end

  def self.clear
    @@cards.clear
  end

end