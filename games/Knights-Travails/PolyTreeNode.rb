class PolyTreeNode
    attr_accessor :value
    attr_reader :parent, :children
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    # def inspect
    # @value.inspect
    # end
    def parent=(node)
        return @parent = nil if node == nil
        @parent.children.reject! { |el| el == self} if @parent != nil
        @parent = node
        @parent.children.push(self) if !@parent.children.include?(self)
    end

    def add_child(childNode)
        childNode.parent = self
        @children << childNode if !@children.include?(childNode)
    end

    def remove_child(childNode)
        raise "this node is not a child" if !@children.include?(childNode)
        childNode.parent = nil
    end

    def dfs(target)
        return self if self.value == target
        
        @children.each do |child|
            result = child.dfs(target)
            return result unless result.nil?
        end
        nil
    end

    def bfs(target)
        nodes = [self]
        until nodes.empty?
            node = nodes.shift
                
            return node if node.value == target
            nodes.concat(node.children)
        end
        nil
    end
end