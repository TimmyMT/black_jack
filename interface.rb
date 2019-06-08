require_relative 'table.rb'

player = User.new
dealer = User.new
Deck.generate
bank = Bank.new

table = Table.new(player, dealer, bank)
print "Введите имя: "
name = gets.chomp
puts "Здравствуйте #{name}! У вас #{player.money} фишек"

loop do
  puts "Делайте ставку"
  ante = gets.chomp.to_i
  table.ante(ante)
  table.start
  puts "Карты диллера: #{dealer.cards[0].card} ** "
  print "Ваши карты: "
  player.cards.each do |c|
    print "#{c.card} "
  end
  player.score
  dealer.score

  puts "\n1# Взять ещё карту? 2# Пас 3# Вскрыть карты"
  action = gets.chomp.to_i
  if action == 1
    table.add_card(player)
    puts "Вы взяли карту"
  end
  if action == 1 || action == 2
    table.dealer_take_card
    puts "Диллер взял карту" if dealer.cards.count > 2
  end

  table.open_cards
  print "Карты диллера: "
  dealer.cards.each do |c|
    print "#{c.card} "
  end
  print "Очки: #{dealer.points}\n"
  print "Ваши карты: "
  player.cards.each do |c|
    print "#{c.card} "
  end
  print "Очки: #{player.points}\n"

  table.who_winner

  if table.winner == 1
    puts "Вы выйграли +#{bank.money}"
  elsif table.winner == 2
    puts "Вы проиграли -#{bank.money}"
  elsif table.winner == 3
    puts "Ничья, фишки возвращаются"
  end

  puts "Фишки диллера #{dealer.money}"
  puts "Ваши фишки #{player.money}"
  break if player.money <= 0 || dealer.money <= 0
end

if player.money <= 0
  puts "Ваши фишки закончились"
elsif dealer.money <= 0
  puts "Фишки диллера закончились"
end
