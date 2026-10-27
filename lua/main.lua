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
  love.graphics.rectangle("fill", 200, 200, 100, 25)
  -- love.graphics.setColor(1, 1, 1)
  -- love.graphics.print("A", 243, 196)
  love.graphics.setColor(0, 1, 0)
  love.graphics.rectangle("fill", 175, 225, 150, 25)
  -- love.graphics.setColor(1, 1, 1)
  -- love.graphics.print("B", 243, 221)
  love.graphics.setColor(1, 0, 0)
  love.graphics.rectangle("fill", 150, 250, 200, 25)
  -- love.graphics.setColor(1, 1, 1)
  -- love.graphics.print("C", 243, 246)

  -- Draw Pegs
  love.graphics.setColor(1, 1, 1)
  love.graphics.rectangle("line", Peg1.x, Peg1.y, PegWidth, PegHeight)
  love.graphics.rectangle("line", Peg2.x, Peg2.y, PegWidth, PegHeight)
  love.graphics.rectangle("line", Peg3.x, Peg3.y, PegWidth, PegHeight)
end
