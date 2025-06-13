
ZoneClass = {}

function ZoneClass:new(x, y, width, height)
  local zone = {}
  local metadata = {__index = ZoneClass}
  setmetatable(zone, metadata)

  zone.position = Vector(x, y)
  zone.size = Vector(width, height)
  zone.offset = 10
  zone.cards = {}

  return zone
end

function ZoneClass:draw()
  love.graphics.setColor(COLOR.LIGHTGRAY)
  love.graphics.rectangle("line", self.position.x, self.position.y, self.size.x, self.size.y)

  for i, card in ipairs(self.cards) do
    card:setPosition(self.position.x + offset, self.position.y)
    card:draw()
  end
end

function ZoneClass:containsCard(card)
  local x, y = card.postion.x, card.position.y
  return x >= self.position.x and 
         x <= self.position.x + self.size.x and
         y >= self.position.y and
         y <= self.position.y + self.size.y
end

function ZoneClass:addCard(card)
  table.insert(self.cards, card)
end