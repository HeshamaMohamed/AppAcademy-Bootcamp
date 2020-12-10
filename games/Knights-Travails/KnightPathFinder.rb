require_relative "./PolyTreeNode"
require 'byebug'
class KnightPathFinder
    attr_accessor :root_node, :considered_positions
    ADD_TO_POSITION = [
        [-2, -1],
        [-2,  1],
        [-1, -2],
        [-1,  2],
        [ 1, -2],
        [ 1,  2],
        [ 2, -1],
        [ 2,  1]
    ]
    def initialize( start_pos )
        @start_pos = start_pos
        @considered_positions = [ start_pos ]
        self.build_move_tree
    end

    def self.valid_moves(pos)
        valid_moves =[]
        x,y = pos
        ADD_TO_POSITION.each do |ax, ay|
            newPos = [ x + ax, y + ay]
            newPosInRange = newPos.all? { |el| el.between?(0,7) }
            valid_moves << newPos if newPosInRange
        end
        valid_moves
    end
    
    def new_move_positions(pos)
        valid = KnightPathFinder::valid_moves(pos)
            .reject { |el| self.considered_positions.include?(el)}

        @considered_positions.concat(valid)
        valid
    end

    def build_move_tree
        self.root_node = PolyTreeNode.new(@start_pos)
        nodes = [root_node]
        until nodes.empty?
            current_node = nodes.shift
            current_position = current_node.value
            new_move_positions(current_position).each do |next_pos|
                next_node = PolyTreeNode.new(next_pos)
                current_node.add_child(next_node)
                nodes << next_node
            end
        end
        nodes
    end
        
    def find_path(end_pos)
        
        target_node = root_node.bfs(end_pos)
        p trace_path_back(target_node)
    end
    
    def trace_path_back(node)
        path = [node.value]
        parent = node.parent
        until parent == nil
            path.unshift(parent.value)
            parent = parent.parent
        end
        path
    end
    
end

kpf = KnightPathFinder.new([0, 0])

kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]
