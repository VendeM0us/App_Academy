class PolyTreeNode
  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  private

  attr_reader :parent, :children, :value
end