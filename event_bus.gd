extends Node

signal level_changed(level_name: String)

func change_level(level_name: String) -> void:
	level_changed.emit(level_name)
