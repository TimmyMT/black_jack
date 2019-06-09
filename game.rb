require_relative 'table.rb'

class Game

  def initialize
    @table = Table.new(introduction)
    start_game
  end

  def introduction
    print "Введите имя: "
    gets.chomp
  end

  def start_game
    puts "Здравствуйте #{@table.player.name}! У вас #{@table.player.money} фишек"
  end

  def play
    loop do
      puts "Делайте ставку!"
      loop do
        @money = gets.chomp.to_i
        break if @table.player.money >= @money && @table.dealer.money >= @money
        puts "Неверная сумма, введите ещё раз!"
      end
      @table.set_money(@money)
      puts "Ставка принята! В банке #{@table.bank.money} фишек"
      @table.start
      puts "Карты диллера: #{@table.dealer.cards[0].value}#{@table.dealer.cards[0].suit} **"
      print "Ваши карты: "
      @table.player.cards.each do |card|
        print "#{card.value}#{card.suit} "
      end
      print "Очки: #{@table.player.points}"
      puts " "

      self.step_two
      self.step_three
      break if @table.player.money <= 0 || @table.dealer.money <= 0
    end

    if @table.player.money <= 0
      puts "У вас закончились фишки"
    elsif @table.dealer.money <= 0
      puts "У диллера закончились фишки"
    end
  end

  def step_two
    puts "1# Взять ещё карту? 2# Пас 3# Вскрыть карты"
    action = gets.chomp.to_i
    @table.take_again(@table.player) if action == 1
    @table.take_again_dealer if action == 1 || action == 2
    puts "Диллер взял карту" if @table.dealer.cards.count > 2
    @table.score_points

    print "Карты диллера: "
    @table.dealer.cards.each do |card|
      print "#{card.value}#{card.suit} "
    end
    print "Очки: #{@table.dealer.points}"
    puts " "
    print "Ваши карты: "
    @table.player.cards.each do |card|
      print "#{card.value}#{card.suit} "
    end
    print "Очки: #{@table.player.points}"
    puts " "
  end

  def step_three
    @table.who_winner

    if @table.winner == @table.player
      puts "Вы выйграли +#{@table.bank.money}"
    elsif @table.winner == @table.dealer
      puts "Вы проиграли -#{@table.bank.money}"
    else
      puts "Ничья! Возврат фишек"
    end

    @table.pay_money

    puts "Фишки диллера: #{@table.dealer.money}"
    puts "Ваши фишки: #{@table.player.money}"

    @table.clear_round
  end

end
