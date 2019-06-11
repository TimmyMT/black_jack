class User
  attr_accessor :money, :points, :cards, :name

  def initialize(name = '')
    @name = name
    @money = 100
    @cards = []
    @points = 0
  end

  def take_card(deck)
    if @cards.count < 3
      random_card = deck.cards.sample
      @cards << random_card
      deck.cards.delete(random_card)
      score
    else
      raise "This user already have 3 cards"
    end
  end

  def score
    @points = 0
    have_a = false
    @cards.each do |card|
      if %w[J Q K].include?(card.value)
        @points += 10
      elsif card.value == 'A'
        @points += 11
        have_a = true
      else
        @points += card.value.to_i
      end
    end
    @points -= 10 if @points > 21 && have_a
  end

  def has_money?
    money <= 0
  end

  def max_cards?
    @cards.count == 3
  end

end
