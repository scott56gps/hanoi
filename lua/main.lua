function love.load()
  Message = "Hola!"
  WindowWidth = 900
  WindowHeight = 700
  WindowXMidpoint = WindowWidth / 2
  WindowYMidpoint = WindowHeight / 2

  love.window.setMode(WindowWidth, WindowHeight)
  love.window.setTitle("Tower of Hanoi")

  Font = love.graphics.newFont(27)

  PegHeight = 150
  PegWidth = 20
  Peg1 = { x = 140, y = WindowHeight - PegHeight }
  Peg2 = { x = 440, y = WindowHeight - PegHeight }
  Peg3 = { x = 740, y = WindowHeight - PegHeight }

  DiscHeight = 25
  local disc1Width = 100
  local disc2Width = 150
  local disc3Width = 200
  Disc1 = {
    x = Peg1.x + (PegWidth / 2) - (disc1Width / 2),
    y = WindowHeight - (DiscHeight * 3),
    width = disc1Width
  }
  Disc2 = {
    x = Peg1.x + (PegWidth / 2) - (disc2Width / 2),
    y = WindowHeight - (DiscHeight * 2),
    width = disc2Width
  }
  Disc3 = {
    x = Peg1.x + (PegWidth / 2) - (disc3Width / 2),
    y = WindowHeight - DiscHeight,
    width = disc3Width
  }
end

function love.keypressed(key)
  if key == "q" then
    love.event.quit()
  end
end

function love.draw()
  love.graphics.setFont(Font)
  love.graphics.setColor(1, 1, 1)
  love.graphics.print(Message)

  -- Draw a Disc
  love.graphics.setColor(0, 0, 1)
  love.graphics.rectangle("fill", Disc1.x, Disc1.y, Disc1.width, DiscHeight)
  -- love.graphics.setColor(1, 1, 1)
  -- love.graphics.print("A", 243, 196)
  love.graphics.setColor(0, 1, 0)
  love.graphics.rectangle("fill", Disc2.x, Disc2.y, Disc2.width, DiscHeight)
  -- love.graphics.setColor(1, 1, 1)
  -- love.graphics.print("B", 243, 221)
  love.graphics.setColor(1, 0, 0)
  love.graphics.rectangle("fill", Disc3.x, Disc3.y, Disc3.width, DiscHeight)
  -- love.graphics.setColor(1, 1, 1)
  -- love.graphics.print("C", 243, 246)

  -- Draw Pegs
  love.graphics.setColor(1, 1, 1)
  love.graphics.rectangle("line", Peg1.x, Peg1.y, PegWidth, PegHeight)
  love.graphics.rectangle("line", Peg2.x, Peg2.y, PegWidth, PegHeight)
  love.graphics.rectangle("line", Peg3.x, Peg3.y, PegWidth, PegHeight)
end
