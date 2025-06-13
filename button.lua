
ButtonPrototype = {}

function ButtonPrototype:new(text, x, y, wide, tall, onClick)
  local button = {}
  local metadata = {__index = ButtonPrototype}
  setmetatable(button, metadata)

  button.text = text
  button.position = Vector(x, y)
  button.size = Vector(wide, tall)
  button.onClick = onClick
  button.counter = 0

  return button
end

function ButtonPrototype:update()
  self:checkForMouseOver(grabber)
end

function ButtonPrototype:draw()
  love.graphics.setColor(COLOR.BLUE)
  love.graphics.rectangle("fill", self.position.x, self.position.y, self.size.x, self.size.y)
  love.graphics.setColor(COLOR.WHITE)
  love.graphics.print(self.text, self.position.x + self.size.x/2, self.position.y + self.size.y/2)
end

function ButtonPrototype:checkForMouseOver(grabber)
  local mousePos = grabber.currentMousePos
  if not mousePos then return false end

  local isMouseOver =
    mousePos.x > self.position.x and
    mousePos.x < self.position.x + self.size.x and
    mousePos.y > self.position.y and
    mousePos.y < self.position.y + self.size.y

  if isMouseOver and self.onClick then
    self.onClick()
    self.counter = self.counter + 1
    print(self.counter)
  end

    
  return isMouseOver
end