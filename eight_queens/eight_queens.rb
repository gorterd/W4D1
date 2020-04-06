require_relative "00_tree_node"
require 'set'
class EightQueens
    attr_reader :roots

    def self.build_roots
        roots = []
        8.times do |i|
            new_node = PolyTreeNode.new([0,i])
            roots << new_node
        end
        roots
    end

    def initialize
        @roots = EightQueens.build_roots
        build_tree
    end

    def build_tree
        grid = Array.new(8) { Set.new(0..7) }
        @roots.each do |root|
            new_grid = remove_invalid_positions(root.value,grid)
            generate_children(root, new_grid)
        end
    end

    def generate_children(node, valid_moves_grid)
        next_row = node.value[0] + 1
        return if next_row >= 8 

        valid_moves_grid[next_row].each do |col|
            new_pos = [next_row, col]
            new_grid = remove_invalid_positions(new_pos, valid_moves_grid)
            new_node = PolyTreeNode.new(new_pos)
            node.add_child(new_node)
            generate_children(new_node, new_grid)
        end
    end

    def remove_invalid_positions(pos, grid)
        new_grid = Array.new(8) {nil}
        old_row = pos[0]
        old_col = pos[1]

        (pos[0]+1..7).each do |row|
            difference = row - old_row
            new_row = grid[row].dup
            new_row.delete(old_col - difference)
            new_row.delete(old_col + difference)
            new_row.delete(old_col)
            new_grid[row] = new_row
        end

        new_grid
    end
end

# a = EightQueens.new
# p a.roots[0].value
# p a.roots[0].children[0].value
# p a.roots[0].children[0].children[0].value
# p a.roots[0].children[0].children[0].children[0].value
# p a.roots[0].children[0].children[0].children[0].children[0].value
# p a.roots[0].children[0].children[0].children[0].children[0].children



# * 0 1 2 3 4 5 6 7 
# 0 Q . . . . . . .
# 1 . . Q . . . . .
# 2 . . . . Q . . . 
# 3 . Q . . . . . . 
# 4 . . . Q . . . . 
# 5 . . . . . . . . 
# 6 . . . . . . . .

