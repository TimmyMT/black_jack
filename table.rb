require_relative 'user.rb'
require_relative 'deck.rb'
require_relative 'bank.rb'

class Table

  attr_accessor :player, :dealer, :round_cards, :bank
  attr_reader :winner

  def initialize(player, dealer, bank)
    @player = player
    @dealer = dealer
    @bank = bank
  end

  def ante(value)
    if @player.money >= value && @dealer.money >= value
      @bank.money = 0
      @bank.money += value * 2
      @dealer.money -= value
      @player.money -= value
    else
      raise "Not enough money"
    end
  end

  def round_clear
    @player.points = 0
    @dealer.points = 0
    @dealer.cards.clear
    @player.cards.clear
    @round_cards = []
  end

  def start
    if @bank.money > 0
      self.round_clear
      loop do
        random_card = Deck.cards.sample
        unless @round_cards.include?(random_card)
          @round_cards << random_card
        end
        break if @round_cards.count == 4
      end

      @dealer.cards << @round_cards[0]
      @dealer.cards << @round_cards[1]
      @player.cards << @round_cards[2]
      @player.cards << @round_cards[3]
    else
      raise "Bank is empty"
    end
  end

  def add_card(user)
    if user.cards.count < 3
      loop do
        random_card = Deck.cards.sample
        unless @round_cards.include?(random_card)
          @round_cards << random_card
          user.cards << random_card
          break
        end
      end
    end
  end

  def dealer_take_card
    if @dealer.points < 17
      self.add_card(@dealer)
    end
  end

  def open_cards
    @dealer.score
    @player.score
  end

  def who_winner
    if @player.points <= 21 && (@dealer.points < @player.points || @dealer.points > 21)
      @player.money += @bank.money
      @winner = 1
    elsif @dealer.points <= 21 && (@player.points < @dealer.points || @player.points > 21)
      @dealer.money += @bank.money
      @winner = 2
    elsif (@dealer.points == @player.points) || (@dealer.points > 21 && @player.points > 21)
      @player.money += @bank.money / 2
      @dealer.money += @bank.money / 2
      @winner = 3
    end
  end

end