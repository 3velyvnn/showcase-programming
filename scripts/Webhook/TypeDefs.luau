--!strict
--!optimize 1
--@author 3velyvnn

export type ColorInput = string | number

export type EmbedField = {
	name: string,
	value: string,
	inline: boolean?,
}

export type EmbedFooter = {
	text: string,
	icon_url: string?,
}

export type EmbedImage = {
	url: string,
}

export type EmbedAuthor = {
	name: string,
	url: string?,
	icon_url: string?,
}

export type EmbedInput = {
	title: string?,
	description: string?,
	url: string?,
	color: ColorInput?,
	fields: { EmbedField }?,
	thumbnail: EmbedImage?,
	image: EmbedImage?,
	footer: EmbedFooter?,
	author: EmbedAuthor?,
}

export type DiscordEmbed = {
	title: string?,
	description: string?,
	url: string?,
	color: number?,
	fields: { EmbedField }?,
	thumbnail: EmbedImage?,
	image: EmbedImage?,
	footer: EmbedFooter?,
	author: EmbedAuthor?,
}

export type WebhookPayload = {
	content: string?,
	username: string?,
	avatar_url: string?,
	embeds: { DiscordEmbed },
}

export type WebhookData = {
	Url: string,
	Payload: WebhookPayload,
}
