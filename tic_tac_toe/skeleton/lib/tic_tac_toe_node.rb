require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator) #:x
    if board.over?
      return !( board.winner == evaluator || board.tied?)
    end

    child = children

    if evaluator == next_mover_mark
      child.all? { |ele| ele.losing_node?(evaluator) }
    else
      child.any? { |ele| ele.losing_node?(evaluator) }
    end
  end
  
  def winning_node?(evaluator)
    if board.over?
      return board.winner == evaluator
    end

    child = children

    if evaluator == next_mover_mark
      child.any? { |ele| ele.winning_node?(evaluator) }
    else
      child.all? { |ele| ele.winning_node?(evaluator) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    result = []
    index_range = (0...board.rows.length)

    index_range.each do |idx| #[0,1]
      index_range.each do |idx_2|
        if board.empty?([idx, idx_2])
          new_board = board.dup
          new_board[[idx, idx_2]] = next_mover_mark
          new_mark = :x

          if next_mover_mark == :x
            new_mark = :o
          end

          new_node = TicTacToeNode.new(new_board, new_mark, [idx, idx_2])
          result << new_node
        end
      end
    end
    result
  end
end
