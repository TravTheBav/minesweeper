require_relative 'board.rb'

class Tile
    attr_reader :board, :bomb, :flag, :revealed

    def initialize(board, bomb = false)
        @board = board  # tile is given a board to track its neighbor tiles
        @bomb = bomb   # tile doesn't get bomb unless specified
        @flag = false # all tiles start unflagged
        @revealed = false # all tiles start hidden
    end

    def reveal
        @revealed = true
    end

    def spawn_bomb
        @bomb = true
    end

end