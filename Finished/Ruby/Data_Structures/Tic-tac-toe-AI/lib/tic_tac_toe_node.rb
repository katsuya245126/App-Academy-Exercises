require_relative 'tic_tac_toe'
require 'byebug'

class TicTacToeNode
  # Constant for marks
  # %i is used for array of symbols
  MARKS = %i[x o].freeze

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return board.winner == opponent_mark(evaluator) if board.over?

    check_for_losing_node = proc { |node| node.losing_node?(evaluator) }

    if next_mover_mark == evaluator
      children.all? check_for_losing_node
    else
      children.any? check_for_losing_node
    end
  end

  def winning_node?(evaluator)
    return board.winner == evaluator if board.over?

    check_for_winning_node = proc { |node| node.winning_node?(evaluator) }

    if next_mover_mark == evaluator
      children.any? check_for_winning_node
    else
      children.all? check_for_winning_node
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    tree = []

    3.times do |y|
      3.times do |x|
        next unless board.empty?([y, x])

        board_copy = board.dup
        board_copy[[y, x]] = next_mover_mark
        next_mark = opponent_mark(next_mover_mark)
        tree << TicTacToeNode.new(board_copy, next_mark, [y, x])
      end
    end

    tree
  end

  def opponent_mark(mark)
    MARKS.dup.reject { |m| m == mark }.first
  end

  def player_mark
    :x
  end

  def cpu_mark
    :o
  end
end
