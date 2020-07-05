require_relative 'poly_tree_node.rb'

class KnightPathFinder
  # Possible movements by knight, matched by index
  X_MOVES = [-1,  1,  2,  2,  1, -1, -2, -2].freeze
  Y_MOVES = [-2, -2, -1,  1,  2,  2,  1, -1].freeze

  def self.valid_moves(pos)
    valid_moves = []

    8.times do |i|
      start_y, start_x = pos
      delta_y = X_MOVES[i]
      delta_x = Y_MOVES[i]

      result = [start_y + delta_y, start_x + delta_x]
      valid_moves << result if valid_pos?(result)
    end

    valid_moves
  end

  def self.valid_pos?(pos)
    pos.is_a?(Array) &&
      pos.size == 2 &&
      pos.all? { |ele| ele.between?(0, 7) }
  end

  def initialize(start)
    @root_node = PolyTreeNode.new(start)
    @considered_positions = [start]
    @move_tree = [@root_node]
  end

  def find_path(end_pos)
    path = []

    current_node = @move_tree.find { |node| node.value == end_pos }
    return nil if current_node.nil?

    until current_node.parent.nil?
      path << current_node.value
      current_node = current_node.parent
    end

    path << @root_node.value
    path.reverse
  end

  def new_move_positions(pos)
    all_possible = KnightPathFinder.valid_moves(pos)
    unseen_moves = all_possible.reject { |p| @considered_positions.include?(p) }
    @considered_positions += unseen_moves
    unseen_moves
  end

  def build_move_tree
    queue = [root_node]

    until queue.empty?
      current_node = queue.shift
      moves = new_move_positions(current_node.value).map do |pos| 
        child = PolyTreeNode.new(pos)
        child.parent = current_node
        child
      end
      @move_tree += moves
      queue += moves
    end
  end

  private

  attr_reader :root_node
  attr_accessor :move_tree
end
