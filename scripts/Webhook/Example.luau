--!strict

local process = require("@lune/process")
local roblox = require("@lune/roblox")

local Color3 = (roblox :: any).Color3
local DISCORD_WEBHOOK: string = process.env.DISCORD_WEBHOOK

local Webhook = require("./WebhookModule")

local hook = Webhook.new(`{DISCORD_WEBHOOK}`)

local response = hook
	:SetUsername("Lune")
	:SetContent("Content Message")
	:AddEmbed({
		title = "Testing",
		description = "Webhook module works!\nRemember to eat your fruits!",

		color = Color3.new(0.541, 0.616, 0.118):ToHex(),

		fields = {
			{
				name = "Status",
				value = "Success",
				inline = true,
			},
		},
	})
	:Send()

print(response.statusCode)
print(response.body)