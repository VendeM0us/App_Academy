require "byebug"

class PolyTreeNode
  attr_reader :parent, :children, :value

  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent=(node)
    unless self.parent.nil?
      old_parent = self.parent
      old_parent.children.delete(self)
    end

    @parent = node

    unless node.nil?
      node.children << self unless node.children.include?(self)
    end
  end

  def add_child(node)
    unless self.children.include?(node)
      self.children << node  
      node.parent = self
    end
  end

  def remove_child(node)
    raise "#{node.value} is not a child" unless self.children.include?(node)
    self.children.delete(node)
    node.parent = nil
  end

  def inspect
    @value.inspect
  end
end