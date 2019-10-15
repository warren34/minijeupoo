class Game
  attr_accessor :human_player, :players_left, :enemies_in_sight
  
  def initialize(name_human_player)
    @human_player = HumanPlayer.new(name_human_player)  
    @players_left = 10
    @enemies_in_sight = []
  end

  def kill_player
    @enemies_in_sight.each do |enemy|
      if enemy.life_points <= 0
        @enemies_in_sight.delete_at(enemies_in_sight.index(enemy))
        @players_left -= 1
      end
    end
  end

  def is_still_ongoing?
    if @human_player.life_points > 0 && @players_left > 0
      return true
    else
      return false    
    end
  end

  def new_players_in_sight
    dice = rand(1..6)
    new_joueur = Player.new("Pirate_#{rand(100..999)}")
    new_joueur_1 = Player.new("Pirate_#{rand(100..999)}")
    if @enemies_in_sight.length == @players_left
      puts "Tous les joueurs sont déjà en vue"
      puts " "    
    else
      if dice == 1
        puts "Aucun joueur adverse en vue" 
        puts " " 
      elsif dice.between?(2,4)
        puts "Joueur adverse en vue"  
        puts " "
        @enemies_in_sight << new_joueur       
      else
        puts "2 joueurs adverses en vue"
        puts " "  
        @enemies_in_sight << new_joueur
        @enemies_in_sight << new_joueur_1  
      end
    end
  end

  def show_players
    puts @human_player.show_state
    puts "Il reste #{@enemies_in_sight.length} ennemis !"
    puts " "
    puts "-"*49
  end

  def menu
    puts "Quelle action veux-tu effectuer ?"
    puts " "
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner" 
    puts " "
    puts "attaquer un joueur en vue :"
    puts " "
    @enemies_in_sight.each do |enemy|
      if enemy.life_points > 0
        puts "#{@enemies_in_sight.index(enemy)} - #{enemy.show_state}"
        puts " "
      end
    end
    print ">"
  end

  def menu_choice
    choice = gets.chomp.to_s
    if choice == "a"
      @human_player.search_weapon
    elsif choice == "s"
      @human_player.search_health_pack
    else
      @enemies_in_sight.each do |enemy|
        if choice == @enemies_in_sight.index(enemy).to_s
          @human_player.attacks(enemy)
        end
      end
    end 
    kill_player
  end

  def enemies_attack
    @enemies_in_sight.each do |enemy|
      if @human_player.life_points > 0
      enemy.attacks(@human_player)
      puts " "
      end
    end
    puts "-"*49
  end

  def end 
    if human_player.life_points >= 0 && @players_left <= 0
      puts "Bravo, tu as gagné la partie, tous les ennemis sont morts"
    elsif human_player.life_points <= 0 && @players_left >= 0
      puts " Désolé; tu as perdu, il restait #{@players_left} ennemis à tuer"
    elsif human_player.life_points <= 0 && @players_left < 0
      puts "C'est une égalité, tout le monde est mort"  
    end  
  end
end

