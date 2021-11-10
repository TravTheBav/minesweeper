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
            pos = get_pos
            board[pos].reveal
            if lose?(pos)
                system("clear")
                board.render
                puts "YOU BLEW UP"
                return
            end
            system("clear")
        end
        puts "B-)"
    end

    # gets position
    def get_pos
        pos = nil
        until pos && valid_pos?(pos)
            begin
                print "Enter coordinates seperated by comma (e.g. '2,1'): "
                pos = gets.chomp.split(",").map { |char| Integer(char) }
            rescue
                puts "Error: coordinates must be in range and seperated by a comma"
            end
        end
        pos
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