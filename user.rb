class User
  attr_accessor :money, :points, :cards

  def initialize
    @money = 100
    @cards = []
    @points = 0
  end

end
