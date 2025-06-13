
CardPrototype = {}

function CardPrototype:new(xPos, yPos, name, cost, power, text, isFaceUp)
  local card = {}
  local metadata = {__index = CardPrototype}
  setmetatable(card, metadata)

  card.position = Vector(xPos, yPos)
  card.name = name or "NAME"
  card.cost = cost or 999
  card.power = power or 999
  card.text = text or "TEXT"
  card.isFaceUp = isFaceUp or TURN_PHASE
  card.state = CARD_STATE.IDLE
  card.size = Vector(cardWidth, cardHeight)

  return card
end

function CardPrototype:update()
  if self.state == CARD_STATE.GRABBED and grabber then
    local mousePos = grabber.currentMousePos
    if mousePos then
      self.position = Vector(mousePos.x - self.size.x/2, mousePos.y - self.size.y/2)
    end
  end
end

function CardPrototype:draw()
  -- Draw drop shadow (if held or hovered)
  if self.state ~= CARD_STATE.IDLE then
    love.graphics.setColor(COLOR.BLACK, 0.8)
    local offset = 4 * (self.state == CARD_STATE.GRABBED and 2 or 1)
    love.graphics.rectangle("fill", self.position.x + offset, self.position.y + offset, self.size.x, self.size.y, 6, 6)
  end

  -- Draw card base
  love.graphics.setColor(COLOR.WHITE)
  love.graphics.rectangle("fill", self.position.x, self.position.y, self.size.x, self.size.y, 6, 6)

  -- Draw card markings
  love.graphics.setColor(COLOR.BLUE)
  love.graphics.printf(self.cost, self.position.x + cardMargin, self.position.y + cardMargin, cardWidth - 2*cardMargin, "left")
  love.graphics.setColor(COLOR.RED)
  love.graphics.printf(self.power, self.position.x + cardMargin, self.position.y + cardMargin, cardWidth - 2*cardMargin, "right")
  love.graphics.setColor(COLOR.BLACK)
  love.graphics.printf(self.name, self.position.x + cardMargin, self.position.y + 3*cardMargin, cardWidth - 2*cardMargin, "center")
  love.graphics.printf(self.text, self.position.x + cardMargin, self.position.y + 6*cardMargin, cardWidth, "left", 0, 0.9, 0.9)

end

function CardPrototype:checkForMouseOver(grabber)
  if self.state == CARD_STATE.GRABBED then
    return
  end

  local mousePos = grabber.currentMousePos
  if not mousePos then return false end

  local isMouseOver =
    mousePos.x > self.position.x and
    mousePos.x < self.position.x + self.size.x and
    mousePos.y > self.position.y and
    mousePos.y < self.position.y + self.size.y

  self.state = isMouseOver and CARD_STATE.MOUSE_OVER or CARD_STATE.IDLE
  
  return isMouseOver
end

function CardPrototype:setPosition(x, y)
  self.position = Vector(x, y)
end
