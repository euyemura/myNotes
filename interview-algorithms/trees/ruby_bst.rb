
class Node
  attr_accessor :value, :left, :right
  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

class BinarySearchTree
  attr_accessor :root
  def initialize
    @root = nil
  end

  def insert(value)
    new_node = Node.new(value)
    if !@root
      @root = new_node
    else
      parse_through_tree(new_node, @root)
    end
    return @root
  end

  def parse_through_tree(node, current_node)
    if node.value > current_node.value
      if current_node.right
        current_node = current_node.right
        parse_through_tree(node, current_node)
      else
        current_node.right = node
        return
      end
    elsif node.value < current_node.value
      if current_node.left
        current_node = current_node.left
        parse_through_tree(node, current_node)
      else
        current_node.left = node
        return
      end
    end
  end

  def lookup(value)
    # lookup_helper(value, @root)
    if !@root
      return false
    end
    current_node = @root
    while current_node
      if value == current_node.value
        return current_node
      elsif value > current_node.value
        current_node = current_node.right
      elsif
        current_node = current_node.left
      end
    end
    return false
  end


  def remove(value)
    if !lookup(value)
      return "Please enter a valid value"
    end

    node_to_override = lookup(value)
    current_node = node_to_override
    if !current_node.right && !current_node.left
      node_to_override = node_to_override.left
      return @root
    elsif !current_node.right
      node_to_override.value = current_node.left.value
      node_to_override.left = nil
      return @root
    else
      current_node = current_node.right
      while (true)
        if !current_node.left.left
          node_to_override.value = current_node.left.value
          current_node.left = current_node.left.right
          return @root
        end
        current_node = current_node.left
      end
    end
  end

  def lookup_helper(value, current_node)
    if value == current_node.value
      return current_node
    elsif value > current_node.value
      if current_node.right
        current_node = current_node.right
        lookup_helper(value, current_node)
      else
        return "There is no value matching #{value}"
      end
    else
      if current_node.left
        current_node = current_node.left
        lookup_helper(value, current_node)
      else
        return "There is no value matching #{value}"
      end
    end

  end
end

bst = BinarySearchTree.new
bst.insert(30)
bst.insert(15)
bst.insert(45)
bst.insert(10)
bst.insert(20)
bst.insert(38)
bst.insert(55)
bst.insert(40)
# bst.insert(53)
bst.remove(55)
