class Validator
  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    # Your code here

    # parse puzzle string to 9x9 int array
    puzzle = extract_numbers(@puzzle_string)

    # check for invalid numbers
    # check each row
    # check each column
    # check each square
    return puzzle
  end

  def extract_numbers (from)

    result = from.scan(/\d*/)                 # getting all the numbers out of the string with Regex
    result.delete("")                                   # removing empty strings
    raise "Sudoku has missing numbers!" unless result.count == 81
    result = result.each_slice(9).to_a        # transforming to a 9x9 array
    result.map! { |row| row.map! { |tile| tile.to_i} }  # casting to integers

    return result
  end
end
