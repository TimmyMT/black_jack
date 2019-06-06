require_relative 'user.rb'

diller = User.new('diller')
print "Введите имя: "
name = gets.chomp
player = User.new(name)
puts "Здравствуйте #{name}! У вас #{player.money} фишек"
puts "Игра началась!"

until diller.money <= 0 || player.money <= 0
  puts "Делайте ставку!"
  set_money = gets.chomp.to_i
  player.money -= set_money
  diller.money -= set_money
  bank = set_money * 2

  puts "Ставки сделаны"
  player.start; diller.start

  puts "Первая карта диллера (#{diller.current_karts[0]})"
  print "Ваши карты ("
  player.current_karts.each {|k| print "#{k} " }
  print ") Очки: #{player.points}\n"

  puts "Выберите действие: 1 - Пас, 2 - Взять ещё карту"
  action = gets.chomp.to_i

  if player.points < 21 && action == 2
    player.add_kart
    print "Ваши карты ("
    player.current_karts.each {|k| print "#{k} " }
    print ") Очки: #{player.points}"
    puts " "
  elsif player.points >= 21 && action == 2
    puts "Достаточно карт"
  end

  if diller.points < 17
    diller.add_kart
    puts "Диллер взял карту"
  end

  puts "Вскрываем карты"
  print "Карты диллера ("
  diller.current_karts.each {|k| print "#{k} " }
  print ") Очки: #{diller.points}\n"
  print "Ваши карты ("
  player.current_karts.each {|k| print "#{k} " }
  print ") Очки: #{player.points}\n"

  if player.points > diller.points && player.points <= 21 || diller.points > 21 && player.points <= 21
    puts "Блек джек!!!!!!!!!!" if player.points == 21
    player.money += bank
    puts "Вы выйграли партию, банк +#{bank} фишек на ваш счёт"
  elsif player.points < diller.points && diller.points <= 21 || player.points > 21 && diller.points <= 21
    diller.money += bank
    puts "Вы проиграли партию, банк #{bank} фишек забирает диллер"
  elsif player.points == diller.points || player.points > 21 && diller.points > 21
    diller.money += bank / 2
    player.money += bank / 2
    puts "Ничья! Фишки возвращаются игрокам"
  end

  puts "У вас #{player.money} фишек"
  puts " "
end

if diller.money <= 0
  puts "У диллера закончились фишки, вы победили"
elsif player.money <= 0
  puts "У вас закончились фишки, игра окончена"
end