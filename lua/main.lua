function love.load()
  Message = ""
  IsWon = false
  Turns = 0
  WindowWidth = 900
  WindowHeight = 700
  WindowXMidpoint = WindowWidth / 2
  WindowYMidpoint = WindowHeight / 2

  love.window.setMode(WindowWidth, WindowHeight)
  love.window.setTitle("Tower of Hanoi")

  Font = love.graphics.newFont(27)

  PegHeight = 150
  PegWidth = 20
  PegMidWidthDistance = PegWidth / 2
  Peg1X = 140
  Peg2X = 440
  Peg3X = 740
  Peg1RegionX = 0
  Peg2RegionX = ((Peg1X + PegMidWidthDistance) + (Peg2X + PegMidWidthDistance)) / 2
  Peg3RegionX = ((Peg2X + PegMidWidthDistance) + (Peg3X + PegMidWidthDistance)) / 2
  DiscHeight = 25
  local disc1Width = 100
  local disc2Width = 150
  local disc3Width = 200
  Disc1 = {
    x = Peg1X + PegMidWidthDistance - (disc1Width / 2),
    y = WindowHeight - (DiscHeight * 3),
    width = disc1Width,
    order = 1
  }
  Disc2 = {
    x = Peg1X + PegMidWidthDistance - (disc2Width / 2),
    y = WindowHeight - (DiscHeight * 2),
    width = disc2Width,
    order = 2
  }
  Disc3 = {
    x = Peg1X + PegMidWidthDistance - (disc3Width / 2),
    y = WindowHeight - DiscHeight,
    width = disc3Width,
    order = 3
  }

  Peg1 = { x = Peg1X, discs = { Disc3, Disc2, Disc1 }, topStackY = WindowHeight - DiscHeight * 3 }
  Peg2 = { x = Peg2X, discs = {}, topStackY = WindowHeight }
  Peg3 = { x = Peg3X, discs = {}, topStackY = WindowHeight }

  SourcePeg = nil
  DraggedDisc = nil
  DragOffsetX = 0
  DragOffsetY = 0
end

function love.keypressed(key)
  if key == "q" then
    love.event.quit()
  end
end

local function isWithinDisc(x, y, disc)
  return
      (y >= disc.y and y <= (disc.y + DiscHeight)) and
      (x >= disc.x and x <= (disc.x + disc.width))
end

function love.mousepressed(x, y, button)
  if button ~= 1 then return end

  for i, peg in ipairs({ Peg1, Peg2, Peg3 }) do
    local topDisc = peg.discs[#peg.discs]
    if topDisc and isWithinDisc(x, y, topDisc) then
      SourcePeg = peg
      DraggedDisc = topDisc
      DragOffsetY = topDisc.y - y -- Captured only ONCE, when a click is detected
      DragOffsetX = topDisc.x - x
      -- Message = "Clicked on Disc" .. i .. "!"
      return
    end
  end

  -- Message = "x: " .. x .. "y: " .. y
end

local function pegCanAcceptDisc(peg, disc)
  return #peg.discs == 0 or disc.order < peg.discs[#peg.discs].order
end

local function placeDiscOnPeg(peg, disc)
  table.insert(peg.discs, disc)
  peg.topStackY = peg.topStackY - DiscHeight
  disc.y = peg.topStackY
  disc.x = peg.x + PegMidWidthDistance - (disc.width / 2)
end

local function removeTopDisc(peg)
  table.remove(SourcePeg.discs)
  peg.topStackY = peg.topStackY + DiscHeight
end

function love.mousereleased(x, y, button)
  if button ~= 1 or not DraggedDisc then return end

  -- Identify the target peg to test if the disc can land on it
  local targetPeg
  if x < Peg2RegionX then targetPeg = Peg1
  elseif x < Peg3RegionX then targetPeg = Peg2
  else targetPeg = Peg3 end

  removeTopDisc(SourcePeg)
  if not pegCanAcceptDisc(targetPeg, DraggedDisc) then
    targetPeg = SourcePeg  -- If the disc cannot be placed, let the disc snap back to the source peg
  else
    Turns = Turns + 1
  end
  placeDiscOnPeg(targetPeg, DraggedDisc)

  DraggedDisc = nil
  SourcePeg = nil
end

local function didWinGame()
  return #Peg3.discs == 3
end

function love.update(dt)
  if DraggedDisc then
    local mouseX = love.mouse.getX()
    local mouseY = love.mouse.getY()
    DraggedDisc.y = mouseY + DragOffsetY
    DraggedDisc.x = mouseX + DragOffsetX
  end
  if didWinGame() then
    IsWon = true
  end
end

local function drawPegs()
  -- Draw Pegs
  love.graphics.setColor(1, 1, 1)
  love.graphics.rectangle("line", Peg1X, WindowHeight - PegHeight, PegWidth, PegHeight)
  love.graphics.rectangle("line", Peg2X, WindowHeight - PegHeight, PegWidth, PegHeight)
  love.graphics.rectangle("line", Peg3X, WindowHeight - PegHeight, PegWidth, PegHeight)

  -- Draw Discs on the Pegs
  for i, peg in ipairs({ Peg1, Peg2, Peg3 }) do
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", peg.x, WindowHeight - PegHeight, PegWidth, PegHeight)

    if peg.discs then
      for j, disc in ipairs(peg.discs) do
        if disc.order == 1 then
          love.graphics.setColor(0, 0, 1)
        elseif disc.order == 2 then
          love.graphics.setColor(0, 1, 0)
        else
          love.graphics.setColor(1, 0, 0)
        end
        love.graphics.rectangle("fill", disc.x, disc.y, disc.width, DiscHeight)
      end
    end
  end
end

function love.draw()
  love.graphics.setFont(Font)
  love.graphics.setColor(1, 1, 1)

  love.graphics.print("Tower of Hanoi", (WindowWidth / 2) - 100, 0)
  love.graphics.print("Quit: q", WindowWidth - 100, 0)

  if IsWon then
    love.graphics.print("You Won!!  The monks are happy.", (WindowWidth / 2) - 250, WindowHeight / 2)
  elseif Turns > 0 then
    love.graphics.print("Turns: " .. Turns)
  end

  drawPegs()
end
