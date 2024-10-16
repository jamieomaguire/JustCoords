-- Local helper function for rounding numbers
local function round(number)
  return math.floor(number + 0.5)
end

-- Local helper function to fetch player map position
local function getPlayerMapPosition()
  local mapId = C_Map.GetBestMapForUnit("player")
  if mapId then
      local position = C_Map.GetPlayerMapPosition(mapId, "player")
      if position then
          local x, y = position:GetXY()
          return x, y
      end
  end
end

-- Local helper function to update coordinates on frames
local function updateFrameCoordinates(frame, x, y)
  if x and y then
      frame:SetText(string.format("%.0f,%.0f", round(x * 100), round(y * 100)))
  else
      frame:SetText("Coordinates unavailable")
  end
end

-- Global function as used by the XML UI configuration
function GetCoordsForPlayerFrame()
  local x, y = getPlayerMapPosition()
  updateFrameCoordinates(JustCoords_PlayerFrame_Text, x, y)
end

-- Global function as used by the XML UI configuration
function GetCoordsForWorldMapFrame()
  local cursorX, cursorY = WorldMapFrame:GetNormalizedCursorPosition()
  local playerX, playerY = getPlayerMapPosition()

  local cursorCoords = string.format("Cursor: %.0f,%.0f", round(cursorX * 100), round(cursorY * 100))
  local playerCoords = playerX and playerY and string.format("Player: %.0f,%.0f", round(playerX * 100), round(playerY * 100)) or "Player: unavailable"
  JustCoords_WorldMapFrame_Text:SetText(cursorCoords .. " // " .. playerCoords)
end
