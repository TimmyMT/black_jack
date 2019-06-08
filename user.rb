class User
  attr_accessor :money, :points, :cards

  def initialize
    @money = 100
    @cards = []
    @points = 0
  end

  def take_card(card)
    if @cards.count < 3
      @cards << card
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
      elsif %w[A].include?(card.value)
        @points += 11
        have_a = true
      else
        @points += card.value.to_i
      end
    end
    @points -= 10 if @points > 21 && have_a == true
  end

end
