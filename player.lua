
PlayerClass = {}

function PlayerClass:new(num)
  local player = {}
  local metadata = {__index = PlayerClass}
  setmetatable(player, metadata)
  
  player.type = PLAYER_TYPE.COMPUTER
  if num == 1 then
    player.type = PLAYER_TYPE.HUMAN
  end
  player.hand = {}
  player.deck = {}
  player.mana = 0
  player.score = 0

  return player
end

function PlayerClass:drawFromDeck()
  if #self.deck > 0 then
    local card = table.remove(self.deck)
    card:setPosition(borderMargin + (#self.hand * (cardWidth+cardMargin)), height - cardHeight)
    table.insert(self.hand, card)
  end
end