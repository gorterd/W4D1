require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    winning_move = false
    pos = nil
    children = node.children

    children.shuffle.each do |child|
      if child.winning_node?(mark)
        pos = child.prev_move_pos
        winning_move = true
        break
      end
    end

    unless winning_move
      children.shuffle.each do |child|
        unless child.losing_node?(mark)
          pos = child.prev_move_pos
          winning_move = true
          break
        end
      end
    end

    unless winning_move
      raise "No non-losing move available"
    end

    return pos #first win

  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
