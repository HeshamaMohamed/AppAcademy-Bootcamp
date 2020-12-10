require_relative './tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    child = []
    (0..2).each do |row|
      (0..2).each do |col|
        pos = [row,col]
        if @board.empty?(pos)
          newBoard = @board.dup
          newBoard[pos] = @next_mover_mark
          next_mover_mark = (self.next_mover_mark == :x ? :o : :x)
         child << TicTacToeNode.new(newBoard, next_mover_mark, pos)
        end
      end
    end
    child
  end

  def losing_node?(evaluator)
    if board.over?
      return board.won? && board.winner !=evaluator
    end

    if self.next_mover_mark == evaluator
      self.children.all? { |child| child.losing_node?(evaluator)}
    else 
      self.children.any? { |child| child.losing_node?(evaluator)}
    end
  end


  def winning_node?(evaluator)
    if board.over?
      return board.won? && board.winner == evaluator
    end

    if self.next_mover_mark == evaluator
      self.children.any? { |child| child.winning_node?(evaluator) }
    else
      self.children.all? { |child| child.winning_node?(evaluator)}
    end
  end
  
end

b = Board.new()
t = TicTacToeNode.new(b,"x")
t.children.each { |el| el.board.rows.each { |row| p row } && puts }