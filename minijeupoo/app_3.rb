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
  my_game = Game.new(human_name)
  return my_game
end

def perform
  affichage
  playing = create_human
  while playing.is_still_ongoing?
    playing.show_players
    playing.new_players_in_sight
    playing.menu
    playing.menu_choice
    playing.enemies_attack
  end  
  playing.end
end

perform