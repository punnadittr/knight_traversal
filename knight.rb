class Node
  attr_accessor :children, :position #value

  def initialize(position = [3,4])
    @position = position
    @children = []
  end

  def add_child(child_node)
    @children << child_node
  end

end

class Tree
  attr_reader :possible_moves

  def initialize(position)
    @initial_move = Node.new(position)
  end

  def create_possible_moves
    possible_moves = []
    x = (0..7).to_a
    y = (0..7).to_a
    x.each do |x_co|
      y.each do |y_co|
        possible_moves << [x_co, y_co]
      end
    end
    @possible_moves = possible_moves
  end

  #calculate one possible move at a time
  def cal(x, y, a, b, node)
    output_1 = []
    output_2 = []
    output_1 << x + a << y + b
    output_2 << x + b << y + a
    if (output_1.all? { |pos| pos >= 0 && pos <= 7 }) && (@possible_moves.include? output_1)
      node.add_child(Node.new(output_1))
      @possible_moves.delete(output_1)
    end
    if (output_2.all? { |pos| pos >= 0 && pos <= 7 }) && (@possible_moves.include? output_2)
      node.add_child(Node.new(output_2))
      @possible_moves.delete(output_2)
    end
  end

  #get all possible moves of one position
  def calc_move(node)
    @possible_moves.delete(node.position)
    x = node.position[0]
    y = node.position[1]
    cal(x, y, -1, -2, node)
    cal(x, y, -1, 2, node)
    cal(x, y, +1, -2, node)
    cal(x, y, 1, 2, node)
  end

  def traverse
    @stack = []
    @stack << @initial_move
    until @stack.empty?
      current_node = @stack.shift
      calc_move(current_node)
      @stack << current_node.children
      @stack.flatten!
    end
  end

  def to_s
    stack = []
    stack << @initial_move
    until stack.empty?
      current_node = stack.shift
      print current_node.position
      stack << current_node.children
      stack.flatten!
    end
  end

  def shortest(path)
    stack = []
    stack << @initial_move
    until stack.empty?
      current_node = stack.shift
      return current_node if current_node.position == path
      stack << current_node.children
      stack.flatten!
    end
  end

  def stack
    @stack
  end

end
mytree = Tree.new([3,4])
mytree.create_possible_moves
mytree.traverse