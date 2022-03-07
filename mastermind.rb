=begin
1. We will construct the two person game with 8 colors:
    red[R], green[G], blue[B], yellow[Y], orange[O], pink[P], silver[S] and white[W]
2. The default game with have 12 rows, or 12 rounds. and 4 guesses. Variations detailed below:
    Expert = 6 rounds
    Hard = 8 rounds
    Normal = 10 rounds
    Easy = 12 rounds
3. We will generate the code at random for the player to guess.
    

=end

class Mastermind
    
    def initialize
        @colors             = ['R', 'G', 'B', 'Y', 'O', 'P', 'S', 'W']
        @mode               = nil
        @rounds             = nil
        @current_round      = 0
        @difficulty_hash    = {Expert: 6, Hard: 8, Normal: 10, Easy: 12}
        @code               = []
        @guess              = []
        @code_check         = []
        @well_placed        = 0
        @misplaced          = 0
        @difficulty_level   = nil
        @duplicate_hash     = {}
        @difficulty_flag    = false
        @quit_flag          = false
        
    end

    def reset_variables
        @guess          = []
        @code_check     = []
        @misplaced      = 0
        @well_placed    = 0
    end

    def generate_code
        index = 0
        while index < 4
            @code << @colors[rand(7)]
            index += 1
        end
        @code.each { |array| @code_check << array}
    end

    def set_rounds 
        puts "Enter one of the following difficulty levels."
        puts "Expert | Hard | Normal | Easy"
        @difficulty_level = gets.chomp.capitalize
        @difficulty_hash.each do |difficulty, rounds|
            if (difficulty == @difficulty_level.to_sym)
                puts "#{difficulty} level set. You have #{rounds} to guess the secret code." 
                @rounds = rounds
                @difficulty_flag = true
            end
        end
        if @difficulty_flag == false
            puts "Did you select the correct difficulty level?"
            set_rounds
        end
    end

    def generate_timer
        start_time = Time.now
    end

    def test
        # generate_code
        @code = ['R', 'R', 'R', 'R']
        set_rounds
        start_game
    end

    def get_guess
        @code.each { |array| @code_check << array}
        @guess = gets.chomp.scan /\w/
    rescue Interrupt
        @quit_flag = true
    end

    def start_game
        puts "Will you guess the secret code?"
        while @current_round < @rounds
            puts "Round #{@current_round}"
            get_guess
            if @quit_flag == true
                puts "Exiting the game"
                return 0
            end
            guess_check
            @current_round += 1
        end
        @current_round + 1 == @rounds and puts "Better Luck Next Time!" and return 0
    end

    def guess_check
        well_placed_pieces
        victory_check
        misplaced_pieces
        
    end

    def well_placed_pieces
        index = 0
        while index < 4 - @well_placed
            if @guess[index] == @code_check[index]
                @well_placed += 1
                @guess.delete_at(index)
                @code_check.delete_at(index)
                index -= 1
            end
            index += 1
        end
        puts "Well-placed pieces : #{@well_placed}"
    end

    def misplaced_pieces
        index = 0
        puts @guess
        puts "break"
        puts @code_check
        while index < 4 - @well_placed
            @guess.each do |guess|
                if guess == @code_check[index]
                    @misplaced += 1
                end
            end
            index += 1
        end
        puts "Misplaced pieces : #{@misplaced}"
        reset_variables
    end

    def duplicate_check
        
    end

    def victory_check
        if @well_placed == 4
            puts "You Won!"
            return 0
       end
    end

end

def main
    testing = Mastermind.new
    testing.test
end

main