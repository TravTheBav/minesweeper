require_relative 'board.rb'

class Tile
    attr_reader :board, :bomb, :flag, :revealed

    def initialize(board:, bomb: false)
        @board = board  # tile is given a board to track its neighbor tiles
        @bomb = bomb   # tile doesn't get bomb unless specified
        @flag = false # all tiles start unflagged
        @revealed = false # all tiles start hidden
    end

    def inspect
        "Position: #{get_pos}\n\tHas Bomb: #{bomb}\n\tHas Flag: #{flag}"
    end

    def reveal
        @revealed = true
    end

    def spawn_bomb
        @bomb = true
    end

    def get_pos
        board.grid.each_with_index do |row, x|
            row.each_with_index do |tile, y|
                pos = [x, y]
                return pos if board[pos].equal? self
            end
        end 
    end

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

end
