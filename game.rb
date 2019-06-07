require_relative 'table.rb'

player = User.new
diller = User.new
deck = Deck.new
bank = Bank.new
table = Table.new(player, diller, deck, bank)

puts "Здравствуйте! У вас #{player.money} фишек"

loop do
  puts "\nДелайте ставку!"
  give = gets.chomp.to_i
  table.ante(give)
  puts "Вы сделали ставку #{give}, банк содержит #{bank.money} фишек"
  table.start

  puts "\nПервая карта диллера: #{diller.cards[0]}"
  puts "Ваши карты: #{player.cards[0]} #{player.cards[1]} Очки: #{player.points}"

  puts " 1# Взять ещё карту? 2# Пас #3 Вскрыть карты"
  action = gets.chomp.to_i
  if action == 1
    table.add_card(player)
  end

  table.count_p(diller)
  if diller.points <= 17 && action != 3
    table.add_card(diller)
    puts "\nДиллер взял карту"
  end

  puts "\nКарты диллера #{diller.cards} Очки: #{diller.points}"
  puts "Ваши карты #{player.cards} Очки: #{player.points}"
  table.open_cards
  puts "У вас #{player.money} фишек\n"
  break if player.money <= 0 || diller.money <= 0
end

if player.money <= 0
  puts "У вас больше нету фишек, игра окончена"
elsif diller.money <= 0
  puts "Фишки диллера закончились"
end
