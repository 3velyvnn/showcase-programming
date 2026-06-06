--!strict
-- Logger.luau

export type LogType =
	"print"
	| "info"
	| "warn"
	| "error"
	| "success"

export type LogEntry = {
	trueType: LogType,
	output: { string },
}

type LoggerMethods = {
	log: (entry: LogEntry) -> (),
	logs: (entries: { LogEntry }) -> (),
}

local Logger: LoggerMethods = {} :: any

local PREFIXES: { [LogType]: string } = {
	print = "📜",
	info = "💡",
	warn = "⚠️",
	error = "❌",
	success = "✅",
}

local function write(logType: LogType, message: string)
	local prefix = PREFIXES[logType]

	print(`{prefix} {message}`)
end

function Logger.log(entry: LogEntry)
	for _, line in entry.output do
		write(entry.trueType, line)
	end
end

function Logger.logs(entries: { LogEntry })
	for _, entry in entries do
		Logger.log(entry)
	end
end

return Logger