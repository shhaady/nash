class Game
  attr_accessor :matrix, :p1_strategy, :p2_strategy, :row_size, :col_size
  
  def initialize(matrix)
    @matrix = matrix
    @p1_strategy = p1_list
    @p2_strategy = p2_list
    @row_size = matrix.size
    @col_size = matrix[0].size
  end
 
  def p1_list
    arr = []
    @matrix.each { |row|
      row.each { |col|
        arr.push(col[0])
      }
    }
    arr
  end
  
  def p2_list
    arr = []
    @matrix.each { |row|
      row.each { |col|
        arr.push(col[1])
      }
    }
    arr
  end
  
  def iterate_p1_strategy
    i = 0
    arr = []
    while i < @row_size
      arr.push(compare_p1_strategy(i))
      i += 1
    end
    arr
  end
  
  def iterate_p2_strategy
    i = 0
    arr = []
    while i < @col_size
      arr.push(compare_p2_strategy(i))
      i += 1
    end
    arr
  end
  
  def compare_p1_strategy(row)
    rows = []
    r = 0
    while r < @p1_strategy.length
      rows << @p1_strategy[r + row]
      r += @row_size
    end
    rows
  end
  
  def compare_p2_strategy(col)
    cols = []
    r = 0
    while r < @col_size
      cols << @p2_strategy[r + (col * @col_size)]
      r += 1
    end
    cols
  end
  
  def eq(matrix)
    matrix.all? {|x| x == matrix[0]}
  end
  
  def isRowIndexStronglyDominated(index)
    matrix = iterate_p2_strategy
    matrix.length.times do |i|
      item = matrix[i][index]
      if matrix[i].max == item 
        return false
      end
    end
    true
  end
  

  def isColIndexStronglyDominated(index)
    matrix = iterate_p1_strategy
    matrix.length.times do |i|
      item = matrix[i][index]
      if matrix[i].max == item 
        return false
      end
    end
    true
  end
  
  
  def removeRowIndex(index)
    @matrix.delete_at(index)
    @p1_strategy = p1_list
    @p2_strategy = p2_list
    @row_size -= 1
  end
  
  def removeColIndex(index)
    @matrix.length.times do |i|
      @matrix[i].delete_at(index)
    end
    @p1_strategy = p1_list
    @p2_strategy = p2_list
    @col_size -= 1
  end
  
  def reduce_row
    flag = true
    @matrix.length.times do |i|
      if (isRowIndexStronglyDominated(i) == true) 
        removeRowIndex(i)
        flag = false
      end
    end
    flag
  end
  
  def reduce_col
    flag = true
    @matrix.length.times do |i|
      if (isColIndexStronglyDominated(i) == true) 
        removeColIndex(i)
        flag = false
      end
    end
   flag
  end

  def reduce
    p1 = false
    p2 = false
    while (p1 != true && p2 != true)
      p1 = reduce_row
      p2 = reduce_col
    end
  end
   
end
