class Player
  attr_accessor :name, :life_points
  
  def initialize(name)
    @name = name   
    @life_points = 10
  end

  def show_state
    if @life_points <= 0 
      @life_points = 0
    end
    return "#{@name} a #{@life_points} points de vie"
  end

  def gets_damage(damage_received)
    @life_points -= damage_received
    if @life_points < 0
      puts "le joueur #{@name} a été tué !"
    end
  end

  def attacks(player)
    puts "le joueur #{@name} attaque le joueur #{player.name} "
    strength = compute_damage
    puts "il lui inflige #{strength} points de dommages"
    puts " "
    player.gets_damage(strength)  
  end
  
  def compute_damage
    return rand(1..6)
  end

end

class HumanPlayer < Player
  attr_accessor :life_points, :weapon_level
  def initialize(name)
    @name = name
    @life_points = 100
    @weapon_level = 1
  end

  def show_state
    return "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}"
  end

  def compute_damage
    rand(1..6) * @weapon_level
  end

  def search_weapon
    new_weapon_level = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{new_weapon_level} !"  
    puts " "  
    if new_weapon_level < @weapon_level
      puts "M@*#$... elle n'est pas mieux que ton arme actuelle..."    
      puts " "        
    elsif new_weapon_level == @weapon_level
      puts "Bof, elle a le même niveau que ton arme actuelle, laisse tomber frérot..."
      puts " "      
    else
      @weapon_level = new_weapon_level
      puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."    
      puts " "        
    end
  end

  def search_health_pack
    pack_found = rand(1..6)
    if pack_found == 1
      puts "Tu n'as rien trouvé" 
      puts " "  
    elsif pack_found >= 2 && pack_found <= 5
      @life_points += 50
      if @life_points > 100
        @life_points = 100    
      end
      puts "Bravo, tu as trouvé un pack de +50 points de vie !"    
      puts " "        
    elsif pack_found == 6
      @life_points += 80
      if @life_points > 100
        @life_points = 100    
      end
      puts "Bravo, tu as trouvé un pack de +80 points de vie !"    
      puts " "      
    end  
  end

end