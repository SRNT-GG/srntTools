srntTools = LibStub("AceAddon-3.0"):NewAddon("srntTools", "AceConsole-3.0", "AceEvent-3.0")

-- Default settings
srntTools.db = {
	autoVendor = true,
	autoSellSpam = true,
	autoRepair = true,
	autoRepairAlwaysText = false, -- Toggles the message displayed when opening a repair vendor, even when at 100% durability.
	customXpBarTextEnabled = true, -- Writes xpbar text as: currentxp / exptotalneeded (expdone%)
	customXpBarFontsize = 12, -- Font size, defaults to expressway.

	customRepBarText = true,
}

-- We need the DB through out the addon
function srntTools:OnInitialize()
	self:RegisterChatCommand("st", "SlashCommand")
	self:RegisterChatCommand("srntTools", "SlashCommand")
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

function srntTools:customXpBarFontsizeGet(info)
	return self.db.customXpBarFontsize
end

function srntTools:customRepBarText(info)
	return self.db.customRepBarText
end

function srntTools:SlashCommand(input)
	srntprint("Options are located in LUA file called srntTools.lua")
end