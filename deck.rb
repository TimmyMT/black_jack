class Deck
  MASTIES = ['♥', '♦', '♣', '♠']
  CARDS = ['2', '3', '4', '5', '6',
           '7', '8', '9', '10',
           'J', 'Q', 'K', 'A']

  attr_reader :cards

  def initialize
    @cards = []
    MASTIES.each do |m|
      CARDS.each do |c|
        @cards << "#{c}#{m}"
      end
    end
  end

end