module PointsCounter

  def points_count(user)
    user.points = 0
    user.cards.each do |c|
      if (c.chop == 'J') || (c.chop == 'Q') || (c.chop == 'K')
        point = 10
      elsif c.chop == 'A'
        point = 11
      else
        point = (c.chop).to_i
      end

      user.points += point
    end

    if user.points > 21
      user.cards.each do |c|
        if c.chop == 'A'
          user.points -= 10
        end
      end
    end
  end

end