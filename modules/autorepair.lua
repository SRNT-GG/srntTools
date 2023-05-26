if not srntTools:IsInitialized() then
    srntprint("Not init..")
    return
end

if srntTools and srntTools:autoRepairGet() then
    local greenText = "|cff00ff00enabled|r"
    srntprint("Auto repair is " .. greenText)
else
    local greenText = "|cffff0000disabled|r"
    srntprint("Auto repair is " .. greenText)
    return 
end

function autoRepair()
    if not MerchantFrame:IsVisible() or not MerchantFrame.selectedTab == 1 then
        return
    end

    local repairCost = GetRepairAllCost()
    if repairCost > 0 then
        if repairCost <= GetMoney() then
            RepairAllItems()
            srntprint("Your equipment has been repaired for " .. GetCoinTextureString(repairCost))
        else
            srntprint("You don't have enough money to repair your equipment.")
        end
    else
        srntprint("Your equipment is already at full durability, no need to repair!")
    end
end

-- Register the event handler
local frame = CreateFrame("Frame")
frame:RegisterEvent("MERCHANT_SHOW")
frame:SetScript("OnEvent", function(self, event, addonName)
    -- Call autoVendor function
    autoRepair()
end)