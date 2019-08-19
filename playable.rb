require_relative 'player'

module Playable
    def blam
        @health -= 10
        puts "#{@name} got blammed!"
    end
    def w00t
        @health += 15
        puts "#{@name} got w00ted!"
    end
    def strong?
        true
    end
    def strong?
        @health > 100
    end
end