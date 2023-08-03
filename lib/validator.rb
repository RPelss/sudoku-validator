class Validator
  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    # Your code here
    msg_invalid = "Sudoku is invalid."
    msg_incomplete = "Sudoku is valid but incomplete."
    msg_complete = "Sudoku is valid."

    # Parse puzzle string to 9x9 int array
    puzzle = extract_numbers(@puzzle_string)

    # Check for invalid numbers
    return msg_invalid unless all_numbers_in_range(puzzle, (0..9).to_a)
    
    # Check each row for duplicates
    puzzle.each do |row|
      return msg_invalid unless all_unique(row)
    end

    # Check each column for duplicates
    for i in 0..8 do
      tmp = Array.new
      # Taking i column value in each row
      puzzle.each do |row|
        tmp.push(row[i])
      end
      return msg_invalid unless all_unique(tmp)
    end

    # Check each square for duplicates
    for i in [0,3,6]
      for j in [0,3,6]
        tmp = get_3x3_square(puzzle, i, j)
        return msg_invalid unless all_unique(tmp)
      end
    end

    # Sudoku is valid
    # Check for any 0 values
    return msg_incomplete unless all_numbers_in_range(puzzle, (1..9).to_a)

    # Sudoku is validated and completed
    return msg_complete
  end

  # Gets all numbers out of the string and puts them into a 9x9 array. 
  def extract_numbers (from)
    result = from.scan(/\d*/) # gets all the numbers out of the string with Regex
    result.delete("") # removes empty strings
    result.map! { |value| value.to_i}  # casts to integers
    result = result.each_slice(9).to_a # transforms to a 9x9 array
    return result
  end

  # Checks if all numbers in the 2D arrray are within range
  def all_numbers_in_range (puzzle, range)
    puzzle.each do |row|
      new_row = row.select { |num| range.include?(num)}
      return false if (new_row.count != row.count)
    end
    return true
  end

  # Checks if 1D array has any repeat values (except 0)
  def all_unique (arr)
    non_zero = arr.select { |num| num > 0}
    return non_zero.uniq.count == non_zero.count
  end

  # Gets a 3x3 square from the puzzle. row and col specifies the upper left corner of the square
  # Returns the square values in a 1D array
  def get_3x3_square (puzzle, row, col)
    result = Array.new;
    
    for i in 0..2
      for j in 0..2
        result.push(puzzle[row + i][col + j])
      end
    end

    return result
  end
end
