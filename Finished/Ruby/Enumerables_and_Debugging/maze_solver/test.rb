require_relative "maze_solver.rb"
require_relative "node.rb"
map = []

File.open("maze2.txt").each_line do |line|
  chars = line.chomp.split("")
  map << chars
end

mazesolver = MazeSolver.new(map)
mazesolver.start
mazesolver.print_maze

node1 = Node.new(nil, [5,1])
node2 = Node.new(nil, [6,2])
end_node = Node.new(nil, [1,14])
