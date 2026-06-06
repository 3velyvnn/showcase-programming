--!nocheck
--!optimize 1
--@creator 3velyvnn

--> Services / Packages
local net = require("@lune/net")
local serde = require("@lune/serde")

--> Type Definitions
local _TDefs = require("./TypeDefs")

type ColorInput = _TDefs.ColorInput
type EmbedInput = _TDefs.EmbedInput
type DiscordEmbed = _TDefs.DiscordEmbed
type WebhookData = _TDefs.WebhookData

--> Logger
local Logger = require("../Logger/Logger")

--> Webhook Class
local Webhook = {}
Webhook.__index = Webhook

export type Webhook = typeof(setmetatable({} :: WebhookData, Webhook))

--> Utility Functions
local function HexToDecimal(hex: string): number
	hex = hex:gsub("^#", "")
	hex = hex:gsub("^0x", "")
	hex = hex:gsub("^0X", "")

	assert(#hex == 6, "Hex color must be 6 characters long, example: #57F287")

	local decimal: number? = tonumber(hex, 16)
	assert(decimal ~= nil, "Invalid hex color: " .. hex)

	return decimal
end

local function ResolveColor(color: ColorInput): number
	if type(color) == "number" then
		return color
	end

	return HexToDecimal(color)
end

--> Constructor
function Webhook.new(url: string): Webhook
	assert(url:match("^https?://"), `Webhook URL must start with http:// or https://, got: {url}`)

	Logger.log({
		trueType = "info",
		output = {
			"Creating new webhook instance...",
		},
	})

	local self = setmetatable({
		Url = url,
		Payload = {
			embeds = {},
		},
	}, Webhook)

	return self
end

--> Configuration Methods
function Webhook:SetUsername(username: string): Webhook
	self.Payload.username = username

	Logger.log({
		trueType = "info",
		output = {
			`Webhook username set to "{username}".`,
		},
	})

	return self
end

function Webhook:SetAvatar(url: string): Webhook
	self.Payload.avatar_url = url

	Logger.log({
		trueType = "info",
		output = {
			"Webhook avatar URL set.",
		},
	})

	return self
end

function Webhook:SetContent(content: string): Webhook
	self.Payload.content = content

	Logger.log({
		trueType = "print",
		output = {
			"Webhook content updated.",
		},
	})

	return self
end

--> Embed Methods
function Webhook:AddEmbed(embed: EmbedInput): Webhook
	local resolvedEmbed: DiscordEmbed = {
		title = embed.title,
		description = embed.description,
		url = embed.url,
		color = if embed.color ~= nil then ResolveColor(embed.color) else nil,
		fields = embed.fields,
		thumbnail = embed.thumbnail,
		image = embed.image,
		footer = embed.footer,
		author = embed.author,
	}

	table.insert(self.Payload.embeds, resolvedEmbed)

	Logger.log({
		trueType = "success",
		output = {
			`Embed added. Total embeds: {#self.Payload.embeds}`,
		},
	})

	return self
end

function Webhook:Send()
	Logger.log({
		trueType = "info",
		output = {
			"Sending webhook request...",
		},
	})

	local response = net.request({
		url = self.Url,
		method = "POST",
		headers = {
			["Content-Type"] = "application/json",
		},
		body = serde.encode("json", self.Payload),
	})

	if response.ok then
		Logger.log({
			trueType = "success",
			output = {
				"Webhook sent successfully.",
			},
		})
	else
		Logger.log({
			trueType = "warn",
			output = {
				`Webhook request failed with status {response.statusCode}.`,
			},
		})
	end

	return response
end

Webhook.HexToDecimal = HexToDecimal
Webhook.ResolveColor = ResolveColor

return Webhook