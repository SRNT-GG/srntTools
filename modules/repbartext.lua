if srntTools and srntTools:customRepBarText() then
    if srntTools:moduleSpamGet() then
        local greenText = "|cff00ff00enabled|r"
        srntprint("Custom rep bar text " .. greenText)
    end
else
    if srntTools:moduleSpamGet() then
        local redText = "|cffff0000disabled|r"
        srntprint("Custom rep bar text " .. redText)
        return
    end
end

-- Create a FontString for the experience text
local repText = ReputationWatchBar:CreateFontString(nil, "OVERLAY", "GameTooltipText")
        
function srntTools:updateRepBar()
    local selectedRepID = GetSelectedFaction()
    local isTrackingInactive = IsFactionInactive(selectedRepID)

    if selectedRepID ~= nil and not isTrackingInactive then
        -- Reputation bar text below.
        local repName, _, _, repBarMin, repBarMax, repBarValue, _, _, _, _, _, hasRep, _, _, factionID = GetFactionInfo(selectedRepID)
        
        local currentRep = repBarValue - repBarMin or 0
        local currentStandingLabel = GetText("FACTION_STANDING_LABEL"..currentRep, UnitSex("player")) or "Unknown"
        local maxRep = repBarMax - repBarMin or 0
        local repPercent = currentRep / maxRep * 100 or 0
        local remainingRep = maxRep - currentRep or 0


        -- Check if expbar is present, if so we add a small vertical ofset to our text.
        local repBarTextOffset = 0
        if MainMenuExpBar:IsVisible() then
            repBarTextOffset = 5
        end
        
        -- Style and set the text.
        repText:SetPoint("CENTER", ReputationWatchBar, "CENTER", 0, repBarTextOffset)
        repText:SetFont(srntTools:customBarFont(), srntTools:customBarFontsize(), "OUTLINE")
        repText:SetJustifyH("CENTER")
        repText:SetJustifyV("MIDDLE")
        repText:SetText(string.format("%s: %d / %d (%.2f%%)", repName, currentRep, maxRep, repPercent))
    end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_XP_UPDATE")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addonName)
    srntTools:updateRepBar()
end)

ReputationWatchBar:HookScript("OnEnter", function(self)
    -- Disable the default text & tooltip.
    ReputationWatchBar.OverlayFrame.Text:Hide()
    GameTooltip:Hide()
end)