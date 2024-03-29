require_relative "player"
require_relative "game_turn"
require_relative "die"
require_relative "treasure_trove"

class Game
    attr_reader :title

    def initialize (title)
        @title = title
        @players = []
    end
    def add_player(a_player)
        @players.push(a_player)
    end
    def play(rounds) 
        puts "There are #{@players.size} players in #{@title}:"
        @players.each do |player|
            puts player
        end
        1.upto(rounds) do |round|
            puts "\nRound #{round}:"
            @players.each do |player|
                GameTurn.take_turn(player)
                puts player
            end
        end
        treasures = TreasureTrove::TREASURES
        puts "\nThere are #{treasures.size} treasures to be found:"
        treasures.each do |treasure|
            puts "A #{treasure.name} is worth #{treasure.points} points"
        end
    end
    def print_name_and_health(player)
        puts "#{player.name} (#{player.health})"
    end

    def print_stats
         puts "\n#{@title} Statistics:"
         
         strong_players, wimpy_players = @players.partition { |player| player.strong? }


        puts "\n#{strong_players.size} strong players:"
        strong_players.each do |player|
            print_name_and_health(player)
        end
        puts "\n#{wimpy_players.size} wimpy players:"
        wimpy_players.each do |player|
            print_name_and_health(player)
        end
        sorted_players = @players.sort { |a, b| b.score <=> a.score }

        puts "\n#{@title} High Schores:"
        @players.sort.each do |player|
            puts high_score_entry(player)
        end
            puts "#{player.points} grand total points"
    
    end
    def load_players(from_file)
        File.readlines(from_file).each do |line|
            add_player(Player.from_csv(line))
        end
    end
    def save_high_scores(player)
        File.open(to_file, "w") do |file|
            file.puts "#{@title} High Schores:"
            @players.sort.each do |player|
                file.puts high_score_entry(player)
            end
        end
    end
end