# Notes
# -Backtracking does not work properly

require_relative "node.rb"

class MazeSolver
  # cost of moving
  # D = up, down, right, left
  # D2 = diagonal
  D = 10
  D2 = 14

  def initialize(maze)
    @open_list = []
    @closed_list = []
    @maze = maze
    @start_pos = find_start(maze)
    @end_pos = find_end(maze)
  end

  def start
    # Make start and end node. Add start node to open list. Set current node to start node
    start_node = Node.new(nil, @start_pos)
    end_node = Node.new(nil, @end_pos)
    @open_list << start_node
    current_node = start_node

    until @open_list.empty?
      # set current node to lowest F cost node. If there are ties, break the tie by choosing node
      # with the highest g cost because further from start = closer to goal
      if @open_list.length > 1
        if @open_list[0].f == @open_list[1].f
          ties = @open_list.select { |node| @open_list[0].f == node.f }
          highest_g = ties.max_by { |node| node.g }
          current_node = highest_g
        else
          current_node = @open_list[0]
        end
      else
        current_node = @open_list[0]
      end

      break if current_node == end_node

      # delete current node from open list and add it to closed list
      @open_list.delete(current_node)
      @closed_list << current_node

      # find reachable squares but skip if they're included in open or closed list
      # if they're not in either list, add to open list after calculating f and h
      reachable(current_node.position, @maze).each do |pos|
        node = Node.new(current_node, pos)
        next if @closed_list.include?(node)

        node.g = current_node.g + (nesw?(current_node.position, node.position) ? D : D2)
        node.h = calc_h(node.position)
        node.f = node.g + node.h

        if @open_list.include?(node)
          idx = @open_list.find_index(node)
          next if node.g > @open_list[idx].g
        end

        @open_list << node 
      end

      #sort open list by F from low to high. 
      #This helps since I can just choose the first element for lowest F
      @open_list.sort_by!(&:f)

      if @open_list.empty? && current_node != end_node
        @open_list << current_node.parent
      end
    end
    
    path = path_to(current_node)
    path.each { |pos| mark(pos) }
    print_maze
  end

  def find_start(maze)
    maze.each_with_index do |line, idx1|
      line.each_with_index do |node, idx2|
        return [idx1, idx2] if node == "S"
      end
    end

    nil
  end

  def find_end(maze)
    maze.each_with_index do |line, idx1|
      line.each_with_index do |node, idx2|
        return [idx1, idx2] if node == "E"
      end
    end

    nil
  end

  # finds walkable square around the current square
  def reachable(current_pos, maze)
    n = [current_pos, [-1, 0]].transpose.map(&:sum)
    ne = [current_pos, [-1, 1]].transpose.map(&:sum)
    e = [current_pos, [0, 1]].transpose.map(&:sum)
    se = [current_pos, [1, 1]].transpose.map(&:sum)
    s = [current_pos, [1, 0]].transpose.map(&:sum)
    sw = [current_pos, [1, -1]].transpose.map(&:sum)
    w = [current_pos, [0, -1]].transpose.map(&:sum)
    nw = [current_pos, [-1, -1]].transpose.map(&:sum)

    # check if valid index
    reachable = [n, ne, e, se, s, sw, w, nw].select do |pos|
      y, x = pos
      if y < 0 || x < 0
        false
      elsif x > maze[0].length - 1 || y > maze.length - 1
        false
      else
        true
      end
    end

    # filter out wall
    reachable.select do |pos|
      y, x = pos
      maze[y][x] != "*"
    end
  end

  def print_maze
    @maze.each do |line|
      line.each do |square|
        print square
      end
      puts ""
    end
  end
  
  # diagonal distance calculated with octile distance
  def calc_h(pos)
    dy = (pos[0] - @end_pos[0]).abs
    dx = (pos[1] - @end_pos[1]).abs

    D * (dx + dy) + (D2 - 2 * D) * [dx, dy].min
  end

  def nesw?(pos, end_pos)
    y1, x1 = pos
    y2, x2 = end_pos

    [y1 - 1, x1] == [y2, x2] || [y1, x1 + 1] == [y2, x2] || [y1 + 1, x1] == [y2, x2] || [y1, x1 - 1] == [y2, x2]
  end

  def mark(pos)
    y, x = pos
    @maze[y][x] = "X" unless @maze[y][x] == "S" || @maze[y][x] == "E"
  end

  def path_to(node)
    return [node.position] if node.parent.nil?
    path = path_to(node.parent)
    path << node.position
    path
  end
end

filepath = ARGV[0]
map = []

File.open(filepath).each_line do |line|
  chars = line.chomp.split("")
  map << chars
end

mazesolver = MazeSolver.new(map)
mazesolver.start