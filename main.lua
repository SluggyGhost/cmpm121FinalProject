
io.stdout:setvbuf("no")

require "card"
--require "commands"
require "config"
require "const"
require "csvReader"
-- require "game"
require "grabber"
require "player"
require "vector"
-- require "zone"

function love.load()
  love.window.setTitle("Clash of Titans")

  -- Set the window and background
  love.window.setMode(width, height)
  love.graphics.setBackgroundColor(COLOR.DARKGREEN)

  -- Game elements
  grabber = GrabberClass:new()
  player1 = PlayerClass:new(1)   -- human player
  player2 = PlayerClass:new(0)   -- computer player
  -- drawnCards = {}
  
  -- Read cards from file
  local cardDataList = loadCSV("cards.csv")
  for _, cardData in ipairs(cardDataList) do
    local card = CardPrototype:new(0, 0, cardData.name, tonumber(cardData.cost), tonumber(cardData.power), cardData.text)
    table.insert(player1.deck, card)
  end

  player1:drawFromDeck()
  player1:drawFromDeck()
  player1:drawFromDeck()
  
  print(width .. ", " .. height)
end

function love.update()
  grabber:update(player1.hand)
  checkForMouseHover()

  for _, card in ipairs(player1.hand) do
    card:update()
  end
end

function love.draw()
  -- Zone outlines
  love.graphics.setColor(COLOR.LIME, 1)
  love.graphics.rectangle("line", borderMargin, borderMargin, width - 2*borderMargin, height - 2*borderMargin)
  local zonePosY = borderMargin + cardHeight
  love.graphics.rectangle("line", borderMargin, zonePosY, zoneWidth, zoneHeight)
  love.graphics.rectangle("line", borderMargin + zoneWidth + zoneMargin, zonePosY, zoneWidth, zoneHeight)
  love.graphics.rectangle("line", borderMargin + 2*zoneWidth + 2*zoneMargin, zonePosY, zoneWidth, zoneHeight)
  zonePosY = zonePosY + zoneHeight + zoneMargin
  love.graphics.rectangle("line", borderMargin, zonePosY, zoneWidth, zoneHeight)
  love.graphics.rectangle("line", borderMargin + zoneWidth + zoneMargin, zonePosY, zoneWidth, zoneHeight)
  love.graphics.rectangle("line", borderMargin + 2*zoneWidth + 2*zoneMargin, zonePosY, zoneWidth, zoneHeight)

  for _, card in ipairs(player1.hand) do
    card:draw()
  end

  love.graphics.setColor(COLOR.WHITE)
  if grabber.currentMousePos then
    love.graphics.print("Mouse: " .. tostring(grabber.currentMousePos.x) .. ", " .. tostring(grabber.currentMousePos.y))
  end
end

function checkForMouseHover()
  if not grabber.currentMousePos then
    return
  end

  for _, card in ipairs(player1.hand) do
    card:checkForMouseOver(grabber)
  end
end
