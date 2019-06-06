class User
  MASTIES = ['+', '<3', '^', '<>']
  KARTS = {'2': 2, '3': 3, '4': 4, '5': 5,
           '6': 6, '7': 7, '8': 8, '9': 9,
           '10': 10, 'J': 10, 'Q': 10, 'K': 10, 'A': 11}

  attr_reader :current_karts, :points, :name
  attr_accessor :money

  def initialize(name)
    @name = name
    @money = 100
    @current_karts = [0]
    @points = 0
  end

  def start
    @current_karts.clear
    @points = 0

    random_kart_first = KARTS.keys.sample
    random_mastie_1 = "#{MASTIES.sample}"
    random_kart_second = KARTS.keys.sample
    random_mastie_2 = "#{MASTIES.sample}"

    if "#{random_kart_second}" + random_mastie_1 != "#{random_kart_first}" + random_mastie_2
      @current_karts << "#{random_kart_second}" + random_mastie_1
      @current_karts << "#{random_kart_first}" + random_mastie_2
      @points += KARTS[random_kart_first]
      @points += KARTS[random_kart_second]

      if @points > 21
        have = false
        @current_karts.each do |k|
          have = true if k['A']
        end
        @points -= 9 if have == true
      end
    else
      self.start
    end
  end

  def add_kart
    if @points < 21
      unless @current_karts.empty?
        random_kart = KARTS.keys.sample
        random_mastie = "#{MASTIES.sample}"

        @current_karts.each do |k|
          if k == "#{random_kart}" + random_mastie
            self.add_kart
          end
        end

        @current_karts << "#{random_kart}" + random_mastie
        @current_karts.pop if @current_karts.count > 3
        @points += KARTS[random_kart] if @current_karts.count <= 3

        if @points > 21
          have = false
          @current_karts.each do |k|
            have = true if k['A']
          end
          @points -= 9 if have == true
        end
      end
    end
  end

end