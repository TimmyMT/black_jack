class User
  attr_accessor :money, :points, :cards

  def initialize
    @money = 100
    @cards = []
    @points = 0
  end

  def score
    @points = 0
    have_a = false
    @cards.each do |card|
      # check_card = c.card.chop
      if %w[J Q K].include?(card)
      # if (check_card ==  'J') || (check_card ==  'Q') || (check_card ==  'K')
        @points += 10
      elsif %w[A].include?(card)
      # elsif check_card == "A"
        @points += 11
        have_a = true
      else
        @points += card.card.chop.to_i #check_card.to_i
      end
    end
    @points -= 10 if @points > 21 && have_a == true
  end

end
