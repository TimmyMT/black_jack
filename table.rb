require_relative 'user.rb'
require_relative 'deck.rb'
require_relative 'bank.rb'
# Deck.generate
# @@pl = User.new
# @@dl = User.new
# @@bnk = Bank.new

class Table

  attr_accessor :player, :diller, :round_cards, :bank
  attr_reader :winner

  def initialize(player, diller, bank)
    @player = player
    @dillder = diller
    @bank = bank
  end

  def ante(value)
    if @player.money >= value && @dillder.money >= value
      @bank.money = 0
      @bank.money += value * 2
      @dillder.money -= value
      @player.money -= value
    else
      raise "Not enough money"
    end
  end

  def start
    if @bank.money > 0
      @player.points = 0
      @dillder.points = 0
      @dillder.cards.clear
      @player.cards.clear
      @round_cards = []

      loop do
        random_card = Deck.cards.sample
        unless @round_cards.include?(random_card)
          @round_cards << random_card
        end
        break if @round_cards.count == 4
      end

      # @round_cards.each do |c|
      #   print "#{c.card} "
      # end
      # puts " "

      @dillder.cards << @round_cards[0]
      @dillder.cards << @round_cards[1]
      @player.cards << @round_cards[2]
      @player.cards << @round_cards[3]

      # puts "Diller cards: #{@dillder.cards[0].card} #{@dillder.cards[1].card}"
      # puts "Player cards: #{@player.cards[0].card} #{@player.cards[1].card}"
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

  def open_cards
    @dillder.score
    @player.score

    if @player.points <= 21 && (@dillder.points < @player.points || @dillder.points > 21)
      @player.money += @bank.money
      @winner = 1
    elsif @dillder.points <= 21 && (@player.points < @dillder.points || @player.points > 21)
      @dillder.money += @bank.money
      @winner = 2
    elsif (@dillder.points == @player.points) || (@dillder.points > 21 && @player.points > 21)
      @player.money += @bank.money / 2
      @dillder.money += @bank.money / 2
      @winner = 3
    end

    # @bank.money = 0

    # print "Diller cards: "
    # @dillder.cards.each do |c|
    #   print "#{c.card} "
    # end
    # print " Points: #{@dillder.points}"
    # puts " "
    #
    # print "Diller cards: "
    # @player.cards.each do |c|
    #   print "#{c.card} "
    # end
    # print " Points: #{@player.points}"
    # puts " "
  end

end