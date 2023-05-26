srntTools = LibStub("AceAddon-3.0"):NewAddon("srntTools", "AceConsole-3.0", "AceEvent-3.0")

-- Default settings
srntTools.db = {
	autoVendor = true,
	autoRepair = true,
	autoSellSpam = true,
	customXpBarTextEnabled = true,
	customXpBarFontsize = 12,
}

-- We need the DB through out the addon
function srntTools:OnInitialize()
	self:RegisterChatCommand("st", "SlashCommand")
	self:RegisterChatCommand("srntTools", "SlashCommand")
end

function srntTools:SlashCommand(input)

end

function srntTools:OnEnable()
	-- Called when the addon is enabled
end

function srntTools:OnDisable()
	-- Called when the addon is disabled
end

-- Setter & Getters
function srntTools:autoRepairGet(info)
	return srntTools.db.autoRepair
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



function srntTools:SlashCommand(input)
	-- We open it twice, to force us to our own config. It's a blizzard bug of over a decade..
	srntprint("Options are located in LUA file called srntTools.lua")
end

