if srntTools and srntTools:customXpBarTextGet() then
    if srntTools:moduleSpamGet() then
        local greenText = "|cff00ff00enabled|r"
        srntprint("Custom XP bar text " .. greenText)
    end
else
    if srntTools:moduleSpamGet() then
        local redText = "|cffff0000disabled|r"
        srntprint("Custom XP bar text " .. redText)
        return
    end
end

-- Exp text needs to be outside, or we'll reinstanciate it over and over.
local expText = MainMenuExpBar:CreateFontString(nil, "OVERLAY", "GameTooltipText")

function srntTools:updateExpBarText()
    if UnitLevel("player") >= 80 then
        return -- Expbar only visible when you're lower level than cap.
    end

    local currentExp = UnitXP("player")
    local maxExp = UnitXPMax("player")
    local expPercent = currentExp / maxExp * 100
    local remainingExp = maxExp - currentExp

    -- Create a FontString for the experience text
    expText:SetPoint("CENTER", MainMenuBarExpText, "CENTER", 0, 0)
    expText:SetFont(srntTools:customBarFont(), srntTools:customBarFontsize(), "OUTLINE")
    expText:SetJustifyH("CENTER")
    expText:SetJustifyV("MIDDLE")
    expText:SetText(string.format("Exp: %d / %d (%.2f%%)", currentExp, maxExp, expPercent))
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_XP_UPDATE")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event, addonName)
    srntTools:updateExpBarText()
end)

MainMenuExpBar:HookScript("OnEnter", function(self)
    -- Disable the default text & tooltip.
    MainMenuBarExpText:Hide()
    GameTooltip:Hide()
end)
