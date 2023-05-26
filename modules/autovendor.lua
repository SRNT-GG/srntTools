local srntTools = LibStub("AceAddon-3.0"):GetAddon("srntTools")
if srntTools:IsInitialized() then
    local db = srntTools.db
    local config = {
        ["autoSellSpam"] = true,
    }
    if srntTools and srntTools:autoVendorGet() then
        local greenText = "|cff00ff00enabled|r"
        srntprint("Auto vendor is " .. greenText)
    else
        local greenText = "|cffff0000disabled|r"
        srntprint("Auto vendor is " .. greenText)
        return 
    end
    local DeleteCursorItem = DeleteCursorItem
    local GetContainerItemInfo = GetContainerItemInfo
    local GetItemInfo = GetItemInfo
    local PickupContainerItem = (C_Container.PickupContainerItem or PickupContainerItem)
    local PickupMerchantItem = (C_Container.PickupMerchantItem or PickupMerchantItem)
    local GetContainerNumSlots = (C_Container.GetContainerNumSlots or GetContainerNumSlots)
    local GetContainerItemLink = (C_Container.GetContainerItemLink or GetContainerItemLink)

    function autoVendor()
        local greyItems = {}
        local totalSellPrice = 0
        -- Construct a table of items to sell
        for bag = 0, 4 do
            local numSlots = GetContainerNumSlots(bag)
            if numSlots then
                for slot = 1, numSlots do
                    local itemLink = GetContainerItemLink(bag, slot)
                    if itemLink then
                        local itemSellPrice = select(11, GetItemInfo(itemLink))
                        local _, _, _, _, _, itemType, itemSubType = GetItemInfo(itemLink)
                        if isItemJunk(itemLink, bag, slot) and itemSellPrice and itemSellPrice > 0 then
                            totalSellPrice = totalSellPrice + itemSellPrice
                            table.insert(greyItems, {
                                ["bag"] = bag,
                                ["slot"] = slot,
                                ["itemLink"] = itemLink
                            })
                        end
                    end
                end
            end
        end

        -- Sell items with a delay of 0.05 seconds
        local loopCounter = 1
        for key, value in pairs(greyItems) do
            if value then
                C_Timer.After(0.15*loopCounter, function()
                    sellItem(value.bag, value.slot, value.itemLink)
                end)
                loopCounter = loopCounter + 1
            end
        end

        -- Report gold value of items to be sold.
        if totalSellPrice > 0 then
            local totalSellTime = #greyItems * 0.15
            C_Timer.After(totalSellTime + 0.30, function()
                srntprint("Sold ".. #greyItems .. " junk items worth " .. GetCoinTextureString(totalSellPrice) .. " it took approximatly ".. totalSellTime .. "sec to sell.")
            end)
            
        end
    end

    -- Sells a individual item, require bag and slot, itemlink is only used if spam is enabled.
    function sellItem(bag, slot, itemLink)
        if not MerchantFrame:IsVisible() or not MerchantFrame.selectedTab == 1 then
            return
        end
        
        if not bag or not slot then
            return
        end

        if srntTools:autoSellSpamGet() and itemLink then
            srntprint("Sold:" ..itemLink)
        end

        -- Sell the it
        PickupContainerItem(bag, slot)
        PickupMerchantItem()
    end

    -- Checks if a item is junk or not
    function isItemJunk(item, bag, slot)
        if not item then
            return false
        end

        -- is it grey quality item?
        local grey = string.find(item,"|cff9d9d9d")
        local armor_weapon = ((sType == "Armor") or (sType == "Weapon"));

        if grey and not armor_weapon then
            return true
        end

        return false
    end

end
-- Register the event handler
local frame = CreateFrame("Frame")
frame:RegisterEvent("MERCHANT_SHOW")
frame:SetScript("OnEvent", function(self, event, addonName)
    -- Call autoVendor function
    if srntTools:isInitialized() then
        autoVendor()
    end
end)