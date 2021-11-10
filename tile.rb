require_relative 'board.rb'

class Tile
    attr_reader :board, :bomb, :flag, :revealed

    def initialize(board:, bomb: false)
        @board = board  # tile is given a board to track its neighbor tiles
        @bomb = bomb   # tile doesn't get bomb unless specified
        @flag = false # all tiles start unflagged
        @revealed = false # all tiles start hidden
    end

    # inspect has been overwritten so that each Tiles' board attribute doesn't get printed to the console
    def inspect
        "Position: #{get_pos}\n\tHas Bomb: #{bomb}\n\tHas Flag: #{flag}"
    end

    # recursively reveals all interior tiles from the original revealed point
    def reveal
        @revealed = true
        if is_interior_tile?
            neighbors.each do |neighbor|
                neighbor.reveal if !neighbor.revealed # only reveal the neighbor if it isn't already revealed
            end
        end
    end

    def spawn_bomb
        @bomb = true
    end

    # returns the Tiles' position
    def get_pos
        board.grid.each_with_index do |row, x|
            row.each_with_index do |tile, y|
                pos = [x, y]
                return pos if board[pos].equal? self
            end
        end 
    end

    # flags tile
    def spawn_flag
        if flag
            @flag = false
        else
            @flag = true
        end            
    end

    # returns an array of all neighboring tiles
    def neighbors
        arr = []
        self_x, self_y = get_pos
        x_range = (self_x - 1..self_x + 1)
        y_range = (self_y - 1..self_y + 1)
        
        board.grid.each_with_index do |row, x|  # checks if the current tile is adjacent
            row.each_with_index do |tile, y|
                if x_range.include?(x) &&
                    y_range.include?(y) &&
                    !self.equal?(board[[x,y]]) # don't want to include self as a neighbor
                    arr << board[[x,y]]
                end
            end
        end

        arr                 
    end

    def neighbor_bomb_count
        neighbors.count { |neighbor| neighbor.bomb }
    end

    def is_interior_tile?
        return true if neighbor_bomb_count == 0
        false
    end

    def render
        if flag # for flagged tiles
            print "F "
        elsif !revealed # for unrevealed tiles that aren't flagged
            print "* "
        else # for all revealed tiles
            if bomb # first check for a bomb
                print "B "
            elsif is_interior_tile? # has no neighboring bombs
                print "_ "            
            else # for unrevealed tiles with adjacent bombs
                print "#{neighbor_bomb_count} "
            end
        end
    end

end
