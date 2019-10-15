require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

def affichage
  up = "-"*49
  puts up
  puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
  puts " "
  puts "|Le but du jeu est d'être le dernier survivant !|"
  puts up
end

def create_human
  puts "Quel est ton nom jeune combattant.e ?"
  puts " "
  print ">"
  human_name = gets.chomp.to_s
  my_gamer = HumanPlayer.new(human_name)
  return my_gamer
end

def game(human_player, array_enemies) 
  choice = ""
  while human_player.life_points > 0 && (array_enemies[0].life_points > 0 || array_enemies[1].life_points > 0) 
    puts " "
    puts "Voici l'état de ton joueur :"
    puts " "
    puts human_player.show_state
    puts " "
    puts "Quelle action veux-tu effectuer ?"
    puts " "
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner" 
    puts " "
    puts "attaquer un joueur en vue :"
    puts " "
    puts "0 - #{array_enemies[0].show_state}"
    puts "1 - #{array_enemies[1].show_state}"
    puts " "
    print ">"
    choice = gets.chomp.to_s
    while choice != "0" && choice != "1" && choice != "a" && choice != "s"
      puts "Ce choix n'est pas valide mon ami" 
      print ">"     
      choice = gets.chomp.to_s
    end
    case choice
    when "0"
      human_player.attacks(array_enemies[0])
    when "1"
      human_player.attacks(array_enemies[1])
    when "a"
      human_player.search_weapon
    when "s"
      human_player.search_health_pack
    else
      puts "Erreur dans le programme" 
    end
    if array_enemies[0].life_points > 0 || array_enemies[1].life_points > 0
      puts "Les autres joueurs t'attaquent !"
    end
    array_enemies.each do |enemies|
      if enemies.life_points > 0
      enemies.attacks(human_player)
      end
    end
    puts "-"*49
  end
  if human_player.life_points > 0
    puts "Bravo, tu as gagné"
  else
    puts " Dommage, tu as perdu"
  end    
end

def perform
  affichage
  human_player = create_human
  player1 = Player.new("Josiane")
  player2 = Player.new("José")
  array_enemies = [player1, player2]
  game(human_player, array_enemies)
end

perform
