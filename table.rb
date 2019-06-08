require_relative 'user.rb'
require_relative 'deck.rb'
require_relative 'bank.rb'

class Table

  attr_accessor :player, :dealer, :bank
  attr_reader :winner, :deck

  def initialize(player, dealer, bank, deck)
    @player = player
    @dealer = dealer
    @bank = bank
    @deck = deck
  end

  def clear_round
    @player.cards.clear
    @player.points = 0
    @dealer.cards.clear
    @dealer.points = 0
    @deck.cards.clear
    @deck.generate
  end

  def start
    if @player.cards.empty? && @dealer.cards.empty?
      2.times do
        random_card = @deck.cards.sample
        @dealer.take_card(random_card)
        @deck.cards.delete(random_card)
      end
      2.times do
        random_card = @deck.cards.sample
        @player.take_card(random_card)
        @deck.cards.delete(random_card)
      end

      self.show
    else
      raise "Users cards not empty"
    end
  end

  def take_again(user)
    random_card = @deck.cards.sample
    user.take_card(random_card)
    @deck.cards.delete(random_card)
    self.show
  end

  def take_again_dealer
    take_again(@dealer) if @dealer.points < 17
  end

  def show
    @dealer.score
    @player.score
  end

  def who_winner
    if @player.points <= 21 && (@dealer.points < @player.points || @dealer.points > 21)
      @winner = 1
    elsif @dealer.points <= 21 && (@player.points < @dealer.points || @player.points > 21)
      @winner = 2
    elsif @player.points == @dealer.points || @player.points > 21 && @player.points > 21
      @winner = 3
    end
  end

  def set_money(value)
    if value <= @player.money && value <= @dealer.money
      @bank.money = value * 2
      @player.money -= value
      @dealer.money -= value
    else
      raise "Wrong value for money"
    end
  end

  def pay_money
    if @winner == 1
      @player.money += @bank.money
    elsif @winner == 2
      @dealer.money += @bank.money
    elsif @winner == 3
      @player.money += @bank.money / 2
      @dealer.money += @bank.money / 2
    end
  end

end