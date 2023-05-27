srntTools = LibStub("AceAddon-3.0"):NewAddon("srntTools", "AceConsole-3.0", "AceEvent-3.0")

-- Default settings
srntTools.db = {
	-- Toggle spam of modules.
	-- This option shows exactly which modules are active, and when they are loaded. It can be spammy.
	moduleSpam = true,

	-- Automation
	autoVendor = true,
	autoSellSpam = true,
	autoRepair = true,
	autoRepairAlwaysText = false, -- Toggles the message displayed when opening a repair vendor, even when at 100% durability.
	
	-- Customization of databars.
	customXpBarTextEnabled = true, -- Writes xpbar text as: "Exp: currentxp / exptotalneeded (expdone%)"
	customRepBarText = true, -- Writes repbar text as: "Faction: currentxp / exptotalneeded (expdone%)"
	-- Point the addOn to your font path. Needs to be inside of interface.
	customBarFont = [[Interface\AddOns\srntTools\fonts\expressway.ttf]], 
	customBarFontsize = 12, -- Font size	
}

function srntTools:OnInitialize()
	self:RegisterChatCommand("st", "SlashCommand")
	self:RegisterChatCommand("srntTools", "SlashCommand")
	local version = GetAddOnMetadata("sToolbox", "Version")
	local addonTitle = "|cff00ff00[srntTools]|r"
	print(addonTitle .. " v." .. version .. " Loaded. By SRNT Gehennas")
end

-- For now, we simply output a direction to config.
function srntTools:SlashCommand(input)
	srntprint("Options are located in LUA file called srntTools.lua")
end

function srntTools:OnEnable()
end

function srntTools:OnDisable()
end

-- Getters
function srntTools:getVersion()
	return GetAddOnMetadata("srntTools", "Version")
end
function srntTools:autoRepairGet(info)
	return self.db.autoRepair
end

function srntTools:autoVendorGet(info)
	return self.db.autoVendor
end

function srntTools:autoSellSpamGet(info)
	return self.db.autoSellSpam
end

function srntTools:customXpBarTextGet(info)
	return self.db.customXpBarTextEnabled
end

function srntTools:customBarFontsize(info)
	return self.db.customBarFontsize
end

function srntTools:customRepBarText(info)
	return self.db.customRepBarText
end

function srntTools:customBarFont(info)
    local fontPath = self.db.customBarFont
    return fontPath
end

function srntTools:moduleSpamGet(info)
	return srntTools.db.moduleSpam
end