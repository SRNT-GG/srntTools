srntTools = LibStub("AceAddon-3.0"):NewAddon("srntTools", "AceConsole-3.0", "AceEvent-3.0")
local options = { 
	name = "srntTools - Configuration",
	handler = srntTools,
	type = "group",
	args = {
		automation = {
			name = "Automation",
            type = "group",
			args = {
				autoVendor = {
					type = "toggle",
					name = "Autovendor",
					desc = "Automatically vendors all gray items, except soulbound items.",
					get = "autoVendorGet",
					set = "autoVendorSet"
				},
				autoRepair = {
					type = "toggle",
					name = "Auto repair",
					desc = "Automatically vendors all gray items, except soulbound items.",
					get = "autoRepairGet",
					set = "autoRepairSet"
				},
				autoSellSpam = {
					type = "toggle",
					name = "Auto sell spam",
					desc = "Toggles detailed chat output of items sold.",
					get = "autoSellSpamGet",
					set = "autoSellSpamSet"
				},
			}
		},
		miscTweaks = {
			name = "Misc tweaks",
            type = "group",
			args = {
				customXpBarText = {
					type = "toggle",
					name = "Experiencebar text",
					desc = "Toggles a diffrent text on the experience bar which is more detailed than the default one.",
					get = "customXpBarTextGet",
					set = "customXpBarTextSet"
				},
				customXpBarFontsize = {
					type = "range",
					min = 8,
					max = 16,
					step = 1,
					name = "Experiencebar fontsize",
					desc = "The size of the text displayed on the experience bar.",
					get = "customXpBarFontsizeGet",
					set = "customXpBarFontsizeSet",
				}
			}
		}
	},

}

-- Default settings
local defaults = {
	profile = {
		autoVendor = true,
		autoRepair = true,
		autoSellSpam = true,
		customXpBarTextEnabled = true,
		customXpBarFontsize = 12,
	},
}
-- We need the DB through out the addon
srntTools.db = false
local isInitialized = false
function srntTools:OnInitialize()
	-- Initialize database.
	srntTools.db = LibStub("AceDB-3.0"):New("srntToolsDB", defaults, true)
	LibStub("AceConfig-3.0"):RegisterOptionsTable("srntTools", options)
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("srntTools", "srntTools")
	self:RegisterChatCommand("st", "SlashCommand")
	self:RegisterChatCommand("srntTools", "SlashCommand")

	isInitialized = true
end

function srntTools:IsInitialized()
    return isInitialized
end

function srntTools:SlashCommand(input)

end

function srntTools:OnEnable()
	-- Called when the addon is enabled
end

function srntTools:OnDisable()
	-- Called when the addon is disabled
end

function srntTools:GetMessage(info)
	return self.db.profile.message
end

function srntTools:SetMessage(info, value)
	self.db.profile.message = value
end

-- Setter & Getters
function srntTools:autoRepairGet(info)
	return self.db.profile.autoRepair
end

function srntTools:autoRepairSet(info, value)
	self.db.profile.autoRepair = value
end

function srntTools:autoVendorGet(info)
	return self.db.profile.autoVendor
end

function srntTools:autoVendorSet(info, value)
	self.db.profile.autoVendor = value
end

function srntTools:autoSellSpamGet(info)
	return self.db.profile.autoSellSpam
end

function srntTools:autoSellSpamSet(info, value)
	self.db.profile.autoSellSpam = value
end

function srntTools:customXpBarTextGet(info)
	return self.db.profile.customXpBarTextEnabled
end

function srntTools:customXpBarTextSet(info, value)
	self.db.profile.customXpBarTextEnabled = value
end

function srntTools:customXpBarFontsizeGet(info)
	return self.db.profile.customXpBarFontsize
end
function srntTools:customXpBarFontsizeSet(info, value)
	self.db.profile.customXpBarFontsize = value
end


function srntTools:SlashCommand(input)
	-- We open it twice, to force us to our own config. It's a blizzard bug of over a decade..
	InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
	InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
end

