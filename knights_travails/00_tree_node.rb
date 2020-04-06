require 'byebug'
class PolyTreeNode
    attr_reader :value, :children, :parent

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(given_parent)                               
        old_parent = @parent          
        @parent = given_parent         

        if old_parent != nil && old_parent != @parent                      
            old_parent.remove_child(self)              
        end
                     
        unless given_parent == nil || @parent.children.include?(self)   
            @parent.add_child(self)                                                
        end
    end

    def add_child(given_child)
        if given_child.parent != nil
            @children << given_child           
        else 
            given_child.parent = self
        end
    end

    def remove_child(given_child)                          
        if given_child.parent != self                       
            child_idx = @children.index(given_child)        
            @children.delete_at(child_idx)
        else
            given_child.parent = nil                       
        end
    end

    def dfs(target)
        return self if self.value == target
        
        self.children.each do |child|
            search_result = child.dfs(target)
            return search_result unless search_result == nil
        end
        nil
    end

    def bfs(target)
        queue = [self]

        until queue.empty?
            first_node = queue.shift
            if first_node.value == target
                return first_node
            else
                queue += first_node.children
            end
        end
        nil
    end

    # def inspect
    #     { 'value' => @value, 'child value' => @children.map(&:value)}.inspect
    # end
end
