require_relative 'user.rb'
require_relative 'deck.rb'
require_relative 'bank.rb'

class Table

  attr_accessor :player, :dealer, :bank
  attr_reader :winner, :deck

  def initialize(name)
    @player = User.new(name)
    @dealer = User.new
    @bank = Bank.new
    @deck = Deck.new
  end

  def clear_round
    @player.cards.clear
    @player.points = 0
    @dealer.cards.clear
    @dealer.points = 0
    @deck.generate
  end

  def start
    if @player.cards.empty? && @dealer.cards.empty?
      2.times do
        @dealer.take_card(@deck)
        @player.take_card(@deck)
      end
    else
      raise "Users cards not empty"
    end
  end

  def take_again(user)
    user.take_card(@deck)
  end

  def take_again_dealer
    take_again(@dealer) if @dealer.points < 17
  end

  def who_winner
    if @player.points <= 21 && (@dealer.points < @player.points || @dealer.points > 21)
      @winner = @player
    elsif @dealer.points <= 21 && (@player.points < @dealer.points || @player.points > 21)
      @winner = @dealer
    elsif @player.points == @dealer.points || @player.points > 21 && @player.points > 21
      @winner = nil
    end
  end

  def set_money(value)
    if value < 0 || value > @player.money || value > @dealer.money
      raise "У вас нет столько фишек, ставьте меньше" if value > @player.money
      raise "У диллера нет столько фишек, ставьте меньше" if value > @dealer.money
      raise "Введите положительное число" if value < 0
    else
      @bank.money = value * 2
      @player.money -= value
      @dealer.money -= value
    end
  end

  def pay_money
    if @winner
      @winner.money += @bank.money
    else
      @player.money += @bank.money / 2
      @dealer.money += @bank.money / 2
    end
  end

end
