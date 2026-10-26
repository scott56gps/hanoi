local function displayBoard(board)
  print("A B C")
  for i = 3, 1, -1 do
    for j = 1, 3 do
      if (board[j][i] == nil) then
        io.write("|")
      else
        io.write(board[j][i])
      end
      if (j > 0) then
        io.write(" ")
      end
    end
    io.write("\n")
  end
end

local function processInput()
  local function validateInput(input)
    return (
      (string.match(input, "^%a%a$")) or
      (string.match(input, "^q$"))
    )
  end

  local inputIsValid = false
  local input = ""
  while not inputIsValid do
    io.write("Please type [Source Peg][Destination Peg] or 'q' to quit: ")
    input = io.read()
    inputIsValid = validateInput(input)
    if not inputIsValid then
      print("Invalid input")
    end
  end
  return input
end

CoordinateMap = { ['A'] = 1, ['B'] = 2, ['C'] = 3 }
local function changeBoard(coordinate, board)
  local upperCoordinate = coordinate:upper()
  if upperCoordinate:match("[ABC][ABC]") then
    local sourcePeg = board[CoordinateMap[upperCoordinate:sub(1, 1)]]
    local destinationPeg = board[CoordinateMap[upperCoordinate:sub(2, 2)]]
    local sourceTop = sourcePeg[#sourcePeg]
    local destinationTop = destinationPeg[#destinationPeg]
    if (sourceTop and sourceTop ~= destinationTop) and      -- They must be different pegs
    (not destinationTop or sourceTop < destinationTop) then  -- The destination must be empty or be greater than the source
      table.insert(destinationPeg, table.remove(sourcePeg))
      return board, true
    end
  end
  return board, false
end

local function validateSolved(board)
  return #(board[#board]) == 3
end

local board = { { 3, 2, 1 }, {}, {} }
local isSolved = false
while not isSolved do
  displayBoard(board)
  local input = processInput()
  if input == "q" then
    os.exit(0)
  end
  local didChange
  board, didChange = changeBoard(input, board)
  if not didChange then
    print("Invalid Coordinate")
  end
  isSolved = validateSolved(board)
end

print("Congratulations!  The monks are happy!")
