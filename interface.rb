require_relative 'game.rb'

class Interface

  def initialize
    @game = Game.new(introduction)
    start_game
  end

  def introduction
    print "Введите имя: "
    gets.chomp
  end

  def start_game
    puts "Здравствуйте #{@game.player.name}! У вас #{@game.player.money} фишек"
  end

  def play
    loop do
      puts "Делайте ставку!"
      begin
        @game.set_money(gets.chomp.to_i)
      rescue => e
        puts e.message
        retry
      end
      puts "Ставка #{@game.ante} принята! В банке #{@game.bank.money} фишек"
      @game.start
      puts "Карты диллера: #{@game.dealer.cards.first.name} **"
      print "Ваши карты: "
      @game.player.cards.each do |card|
        print "#{card.name} "
      end
      print "Очки: #{@game.player.points}\n"

      step_two
      step_three
      break if @game.player.has_money? || @game.dealer.has_money?
    end

    if @game.player.has_money?
      puts "У вас закончились фишки"
    elsif @game.dealer.has_money?
      puts "У диллера закончились фишки"
    end
  end

  def step_two
    puts "1# Взять ещё карту? 2# Пас 3# Вскрыть карты"
    action = gets.chomp.to_i
    @game.take_again(@game.player) if action == 1
    @game.take_again_dealer if action != 3
    puts "Диллер взял карту" if @game.dealer.max_cards?

    print "Карты диллера: "
    @game.dealer.cards.each do |card|
      print "#{card.name} "
    end
    print "Очки: #{@game.dealer.points}\n"
    print "Ваши карты: "
    @game.player.cards.each do |card|
      print "#{card.name} "
    end
    print "Очки: #{@game.player.points}\n"
  end

  def step_three
    @game.who_winner

    if @game.winner == @game.player
      puts "Вы выйграли +#{@game.bank.money}"
    elsif @game.winner == @game.dealer
      puts "Вы проиграли -#{@game.bank.money}"
    else
      puts "Ничья! Возврат фишек"
    end

    @game.pay_money

    puts "Фишки диллера: #{@game.dealer.money}"
    puts "Ваши фишки: #{@game.player.money}"

    @game.clear_round
  end

end
