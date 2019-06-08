require_relative 'table.rb'

class Game

  def initialize
    @player = User.new
    @dealer = User.new
    @bank = Bank.new
    @deck = Deck.new
    @deck.generate
    @table = Table.new(@player, @dealer, @bank, @deck)
  end

  def start_game
    print "Введите имя: "
    name = gets.chomp
    puts "Здравствуйте #{name}! У вас #{@player.money} фишек"
  end

  def play
    loop do
      puts "Делайте ставку!"
      money = gets.chomp.to_i
      @table.set_money(money)
      puts "Ставка принята! В банке #{@bank.money} фишек"
      @table.start
      puts "Карты диллера: #{@dealer.cards[0].value}#{@dealer.cards[0].mastie} **"
      print "Ваши карты: "
      @player.cards.each do |card|
        print "#{card.value}#{card.mastie} "
      end
      print "Очки: #{@player.points}"
      puts " "
      puts "1# Взять ещё карту? 2# Пас 3# Вскрыть карты"
      action = gets.chomp.to_i
      @table.take_again(@player) if action == 1
      @table.take_again_dealer if action == 1 || action == 2
      puts "Диллер взял карту" if @dealer.cards.count > 2
      @table.show

      print "Карты диллера: "
      @dealer.cards.each do |card|
        print "#{card.value}#{card.mastie} "
      end
      print "Очки: #{@dealer.points}"
      puts " "
      print "Ваши карты: "
      @player.cards.each do |card|
        print "#{card.value}#{card.mastie} "
      end
      print "Очки: #{@player.points}"
      puts " "

      @table.who_winner
      @table.pay_money

      if @table.winner == 1
        puts "Вы выйграли +#{@bank.money}"
      elsif @table.winner == 2
        puts "Вы проиграли -#{@bank.money}"
      elsif
      puts "Ничья! Возврат фишек"
      end

      puts "Фишки диллера: #{@dealer.money}"
      puts "Ваши фишки: #{@player.money}"

      @table.clear_round
      break if @player.money <= 0 || @dealer.money <= 0
    end

    if @player.money <= 0
      puts "У вас закончились фишки"
    elsif @dealer.money <= 0
      puts "У диллера закончились фишки"
    end
  end

end
