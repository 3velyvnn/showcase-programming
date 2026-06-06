--!strict

local Logger = require("./Logger")

Logger.logs({
	{
		trueType = "print",
		output = {
			"Starting webhook service...",
			"Loading configuration...",
		},
	},

	{
		trueType = "info",
		output = {
			"Connected to Roblox API",
		},
	},

	{
		trueType = "warn",
		output = {
			"Rate limit nearing threshold",
		},
	},

	{
		trueType = "success",
		output = {
			"Webhook delivered successfully",
		},
	},

	{
		trueType = "error",
		output = {
			"Failed to decode JSON response",
		},
	},
})