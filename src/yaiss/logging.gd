extends RefCounted

enum Level { DEBUG, INFO, WARNING, ERROR }

static func record(level: Level, msg: String, tags: Array[String] = []) -> void:
	var tags_str = "[".join(tags)
	var datetime = Time.get_datetime_string_from_system(false, true)
	print("[%s][%s][%s] %s" % [datetime, Level.find_key(level), tags_str, msg])
