require 'pry'

class PolyTreeNode
  attr_reader :value, :parent
  attr_accessor :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(parent_node)
    parent.children.delete(self) unless parent.nil? #

    @parent = parent_node

    parent_node.children.push(self) unless parent_node.nil? || parent_node.children.include?(self)
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise 'No such child' unless children.include?(child_node)

    child_node.parent = nil
  end

  def dfs(val)
    return self if value == val

    children.each do |child|
      result = child.dfs(val)
      return result unless result.nil?
    end

    nil
  end

  def bfs(val)
    queue = [self]

    until queue.empty?
      v = queue.shift
      return v if v.value == val

      queue += v.children
    end

    nil
  end

  def inspect
    "value: #{value}, parent: (#{parent.inspect}), children: #{children}"
  end
end
