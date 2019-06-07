require_relative 'user.rb'
require_relative 'deck.rb'
require_relative 'points_counter.rb'
require_relative 'bank.rb'

class Table
  include PointsCounter

  attr_accessor :deck, :player, :diller, :bank, :round_cards

  def initialize(player, diller, deck, bank)
    @player = player
    @diller = diller
    @deck = deck
    @bank = bank
  end

  def ante(value)
    if value <= @player.money && value <= @diller.money
      @bank.money += value * 2
      @player.money -= value
      @diller.money -= value
    elsif value > @diller.money
      puts "У диллера нету сколько фишек, введите другую сумму"
      new_value = gets.chomp.to_i
      self.ante(new_value)
    elsif value > @player.money
      puts "У вас нету столько фишек, введите другую сумму"
      new_value = gets.chomp.to_i
      self.ante(new_value)
    end
  end

  def start
    if @bank.money > 0
      @player.cards.clear
      @diller.cards.clear
      @round_cards = []

      4.times do
        loop do
          random_card = @deck.cards.sample
          unless @round_cards.include?(random_card)
            @round_cards << random_card
            break
          end
        end
      end

      @player.cards << @round_cards[0]
      @player.cards << @round_cards[1]
      @diller.cards << @round_cards[2]
      @diller.cards << @round_cards[3]

      points_count(@player)
      points_count(@diller)
    end
  end

  def count_p(user)
    points_count(user)
  end

  def add_card(user)
    if user.cards.count != 3 && user.cards.count < 3
      loop do
        random_card = @deck.cards.sample
        unless @round_cards.include?(random_card)
          @round_cards << random_card
          user.cards << random_card
          break
        end
      end
      points_count(user)
    end
  end

  def open_cards
    points_count(@player)
    points_count(@diller)

    if @player.points <= 21 && (@diller.points < @player.points || @diller.points > 21)
      @player.money += @bank.money
      puts "Вы выйграли +#{@bank.money}"
    elsif @diller.points <= 21 && (@player.points < @diller.points || @player.points > 21)
      @diller.money += @bank.money
      puts "Диллер выйграл -#{@bank.money}"
    elsif (@player.points == @diller.points) || (@player.points > 21 && @diller.points > 21)
      puts "Ничья +#{@bank.money / 2}"
      @player.money += @bank.money / 2
      @diller.money += @bank.money / 2
    end

    @bank.money = 0
  end

end