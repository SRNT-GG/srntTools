if srntTools and srntTools:customRepBarText() then
    local greenText = "|cff00ff00enabled|r"
    srntprint("Custom rep bar text " .. greenText)
else
    local redText = "|cffff0000disabled|r"
    srntprint("Custom rep bar text " .. redText)
    return 
end

function srntTools:updateRepBar()
    local selectedRepID = GetSelectedFaction()
    local isTrackingInactive = IsFactionInactive(selectedRepID)

    if selectedRepID ~= nil and not isTrackingInactive then
        -- Expbar text variablesw
        local repName, repDescription, repStandingID, repBarMin, repBarMax, repBarValue, repAtWarWith, repCanToggleAtWar, _, isHeader, isCollapsed, hasRep, isWatched, isChild, factionID = GetFactionInfo(selectedRepID)
        if not hasRep then
            return
        end
        
        local currentRep = repBarValue - repBarMin
        local currentStandingLabel = GetText("FACTION_STANDING_LABEL"..currentRep, UnitSex("player"))
        local maxRep = repBarMax - repBarMin
        local repPercent = currentRep / maxRep * 100
        local remainingRep = maxRep - currentRep

        -- Create a FontString for the experience text
        local repText = ReputationWatchBar:CreateFontString(nil, "OVERLAY", "GameTooltipText")
        local repBarTextOffset = 0
        if MainMenuExpBar:IsVisible() then -- Exp bar is shown, we slightly nudge our text up to avoid graphical issues.
            repBarTextOffset = 5
        end
        repText:SetPoint("CENTER", ReputationWatchBar, "CENTER", 0, repBarTextOffset)
        repText:SetFont([[Interface\AddOns\srntTools\fonts\expressway.ttf]], srntTools:customXpBarFontsizeGet(), "OUTLINE")
        repText:SetJustifyH("CENTER")
        repText:SetJustifyV("MIDDLE")
        repText:SetText(string.format("%s: %d / %d (%.2f%%)", repName, currentRep, maxRep, repPercent))
    end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_XP_UPDATE")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event, addonName)
    srntTools:updateRepBar()
end)

ReputationWatchBar:HookScript("OnEnter", function(self)
        -- Disable the default text & tooltip.
    ReputationWatchBar.OverlayFrame.Text:Hide()
    GameTooltip:Hide()
end)