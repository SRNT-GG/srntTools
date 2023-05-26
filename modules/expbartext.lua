if not srntTools:IsInitialized() then
    srntprint("Not init..")
    return
end


if srntTools and srntTools:customXpBarTextGet() then
    local greenText = "|cff00ff00enabled|r"
    srntprint("Auto vendor is " .. greenText)
else
    local greenText = "|cffff0000disabled|r"
    srntprint("Custom XP bar text " .. greenText)
    return 
end
local config = {
    ["xpBar"] = {
        ["customXpBarTextEnabled"] = true,
        ["customXpBarTextSize"] = 14,
    }
}
if UnitLevel("player") < 80 or not srntTools:customXpBarTextGet() then
    -- Expbar text variablesw
    local currentExp = UnitXP("player")
    local maxExp = UnitXPMax("player")
    local expPercent = currentExp / maxExp * 100
    local remainingExp = maxExp - currentExp

    -- Create a FontString for the experience text
    local expText = MainMenuExpBar:CreateFontString(nil, "OVERLAY", "GameTooltipText") --frame:CreateFontString(nil, "OVERLAY", "GameTooltipText")
    expText:SetPoint("CENTER", MainMenuBarExpText, "CENTER", 0, 0)
    expText:SetFont([[Interface\AddOns\sToolbox\fonts\expressway.ttf]], srntTools:customXpBarFontsizeGet(), "OUTLINE")
    expText:SetJustifyH("CENTER")
    expText:SetJustifyV("MIDDLE")
    expText:SetText(string.format("Exp: %d / %d (%.2f%%)", currentExp, maxExp, expPercent))

    local frame = CreateFrame("Frame")
    frame:RegisterEvent("PLAYER_XP_UPDATE")
    frame:RegisterEvent("PLAYER_ENTERING_WORLD")
    frame:SetScript("OnEvent", function(self, event, addonName)
        -- Update exptext whenever exp is gained
        currentExp = UnitXP("player")
        maxExp = UnitXPMax("player")
        expPercent = currentExp / maxExp * 100
        remainingExp = maxExp - currentExp
        expText:SetText(string.format("Exp: %d / %d (%.2f%%)", currentExp, maxExp, expPercent))
    end)

    MainMenuExpBar:HookScript("OnEnter", function(self)
        -- Disable the default text & tooltip.
        MainMenuBarExpText:Hide()
        GameTooltip:Hide()
    end)
end