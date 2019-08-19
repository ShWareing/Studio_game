require_relative 'auditable'

class Die
    include Auditable 
    
    attr_reader :number

    def initialize
        roll
    end
    def roll
        rand(1..6)
    end
end