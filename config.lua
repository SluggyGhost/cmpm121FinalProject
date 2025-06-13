
turnCount = 0
winningScore = 20
turnLimit = false   -- Off by default
maxTurns = 0
numHumanPlayers = 1 -- One player by default
numComPlayers = 1   -- One computer competitor by default

width = 1152
height = 768
centerX, centerY = width/2, height/2
borderMargin = height/40

cardWidth, cardHeight = 120, 168
cardMargin = 4


zoneMargin = borderMargin/2
zoneWidth = (width - (2*borderMargin) - (2*zoneMargin)) / 3
zoneHeight = (height - (2*borderMargin) - zoneMargin - (2*cardHeight)) / 2
