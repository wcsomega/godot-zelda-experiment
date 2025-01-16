extends Node2D

var _level: Node2D

func _ready() -> void:
	EventBus.level_changed.connect(change_level)
	_level = load("res://Levels/house_ext_test/house_ext_test.tscn").instantiate()
	add_child(_level)
	
func change_level(name: String) -> void:
	remove_child(_level)
	_level.queue_free()
	
	_level = load(name).instantiate()
	add_child(_level)
