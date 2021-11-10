require_relative 'tile.rb'

class Board
    attr_reader :width, :bombs, :grid

    def initialize(width:, bombs:)
        @width = width
        @bombs = bombs
        @grid = Array.new(width) { Array.new(width) { Tile.new(board: self) } }
    end

    # selects x random numbers where x is the total amount of bombs
    # from within the range of the boards area
    def rng_positions
        possible_numbers = []
        (0...board_area).each { |n| possible_numbers << n }
        possible_numbers.sample(bombs)
    end

    def board_area
        width ** 2
    end

    def [](pos)
        x, y = pos
        grid[x][y]
    end

    # populates the board with bombs based off the RNG from rng_positions
    def populate_bombs
        counter = 0
        positions = rng_positions
        grid.each_with_index do |row, x|
            row.each_with_index do |tile, y|
                if positions.include?(counter)
                    pos = [x, y]
                    self[pos].spawn_bomb
                end
                counter += 1
            end
        end
    end

    def render
        puts "  #{(0...width).to_a.join(" ")}"
        grid.each_with_index do |row, x|
            print "#{x} "
            row.each_with_index do |tile, y|
                pos = [x, y]
                self[pos].render
            end
            puts
        end
        nil
    end

    def unrevealed_tile_count
        grid.flatten.count { |tile| !tile.revealed }
    end

end