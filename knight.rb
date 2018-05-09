class Node
  attr_accessor :children, :position, :parent

  def initialize(position = [3,4], parent = nil)
    @position = position
    @parent = parent
    @children = []
  end

  def add_child(child_node)
    @children << child_node
  end
end

class Tree
  attr_reader :possible_moves

  def initialize
   create_all_moves
  end

  def create_all_moves
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

  # get one possible move of one position
  def cal(a, b, node)
    x = node.position[0]
    y = node.position[1]
    output = []
    output.push([x+a, y+b],[x+b, y+a])
    output.each do |pos|
      if @possible_moves.include? pos
        node.add_child(Node.new(pos, node))
        @possible_moves.delete(pos)
      end
    end
  end

  #get all possible moves of one position
  def calc_move(node)
    @possible_moves.delete(node.position)
    cal(-1, -2, node)
    cal(-1, 2, node)
    cal(+1, -2, node)
    cal(1, 2, node)
  end
  # get all possible moves of all positions
  def find_all_moves
    stack = []
    stack << @initial_move
    until stack.empty?
      current_node = stack.shift
      calc_move(current_node)
      stack << current_node.children
      stack.flatten!
    end
  end

  def knight_moves(first_move, second_move)
    @initial_move = Node.new(first_move)
    create_all_moves
    find_all_moves
    stack = []
    output = []
    stack << @initial_move
    until stack.empty?
      current_node = stack.shift
      if current_node.position == second_move
        until current_node.nil?
          output << current_node.position
          current_node = current_node.parent
        end
        puts "You made it in #{output.size-1} moves! Here's your path:"
        return output.reverse.each { |pos| print pos; puts }
      else
        stack << current_node.children
        stack.flatten!
      end
    end
  end
end

mytree = Tree.new
#test
1000.times do
  mytree.knight_moves([rand(0..7),rand(0..7)], [rand(0..7),rand(0..7)])
end