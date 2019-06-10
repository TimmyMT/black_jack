require_relative 'user.rb'
require_relative 'deck.rb'
require_relative 'bank.rb'

class Table

  attr_accessor :player, :dealer, :bank
  attr_reader :winner, :deck, :interrupted

  def initialize(name)
    @player = User.new(name)
    @dealer = User.new
    @bank = Bank.new
    @deck = Deck.new
    @deck.generate
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

      self.score_points
    else
      raise "Users cards not empty"
    end
  end

  def take_again(user)
    random_card = @deck.cards.sample
    user.take_card(random_card)
    @deck.cards.delete(random_card)
    self.score_points
  end

  def take_again_dealer
    take_again(@dealer) if @dealer.points < 17
  end

  def score_points
    @dealer.score
    @player.score
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
    if value > @player.money || value > @dealer.money
      raise "Wrong value for money"
    else
      @bank.money = value * 2
      @player.money -= value
      @dealer.money -= value
    end
  rescue => e
    puts "Недостаточно фишек! Ещё раз"
    set_money(gets.chomp.to_i)
  end

  def pay_money
    if @winner == @player
      @player.money += @bank.money
    elsif @winner == @dealer
      @dealer.money += @bank.money
    else
      @player.money += @bank.money / 2
      @dealer.money += @bank.money / 2
    end
  end

end
