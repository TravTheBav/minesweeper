require_relative 'board.rb'

class Game
    attr_reader :board

    def initialize(board)
        @board = board
    end

    # main game loop
    def run
        board.populate_bombs
        until win?
            board.render
            input = get_input
            prefix, pos = input
            
            case prefix
            when "r"                
                board[pos].reveal
                if lose?(pos) # only check for a loss when revealing tiles
                    system("clear")
                    board.render
                    puts "YOU BLEW UP"
                    return
                end
            when "f"
                board[pos].spawn_flag
            else
                "Error: prefix with 'r' or 'f'"
            end

            system("clear")
        end
        puts "B-)"
    end

    # gets position
    def get_input
        pos = nil
        until pos && valid_pos?(pos)
            begin
                puts "Use prefix 'r' for reveal or 'f' for flag"
                print "Enter coordinates seperated by comma (e.g. 'r 2,1'): "
                input = gets.chomp.split(" ")
                input[1] = input[1].split(",").map { |char| Integer(char) }
                pos = input[1]
            rescue
                puts "Error: coordinates must be in range and seperated by a comma"
            end
        end
        input
    end

    # checks for a valid position
    def valid_pos?(pos)
        x, y = pos
        range = (0...board.width)
        if range.include?(x) && range.include?(y)
            return true
        end
        false
    end

    def lose?(pos)
        return true if board[pos].bomb
    end

    def win?
        board.unrevealed_tile_count == board.bombs
    end

end

b = Board.new(width:9, bombs:10)
g = Game.new(b)
g.run