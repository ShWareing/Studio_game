require_relative "treasure_trove"
require_relative 'playable'

class Player

    attr_accessor :name
    attr_reader :health
    include Playable
    
    def initialize(name, health=100)
        @name = name.capitalize
        @health = health
        @found_treasure = Hash.new(0)
    end
    def score
        @health + points
    end
    def to_s
        "I'm #{@name} with a health = #{@health}, points = #{points}, and a score = #{score}." 
    end
    def strong?
        true
    end
    def <=>(other)
        other.score <=> score
    end
    def found_treasure(treasure)
        @found_treasure[treasure.name] += treasure.points
        puts "#{@name} found a #{treasure.name} worth #{treasure.points} points."
        puts "#{@name}'s treasures: #{@found_treasure}"
    end
    def points
        @found_treasure.values.reduce(0, :+)
    end
    def each_found_treasure
        @found_treasure.each do |name, points|
            yield Treasure.new(name, points)
        end
    end
    def self.from_csv(string)
        name, health = string.split(',')
        Player.new(name, Integer(health))
    end
end