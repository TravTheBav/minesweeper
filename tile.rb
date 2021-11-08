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
        puts "Position: #{get_pos}"
        puts "Has Bomb: #{bomb}"
        puts "Has Flag: #{flag}"
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
        board.select 
    end

end