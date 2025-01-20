extends Node2D

var _level: Node2D
@onready var _player: Node2D = $Player

func _ready() -> void:
	EventBus.level_changed.connect(change_level)
	change_level("res://Levels/house_ext_test/house_ext_test.tscn")

func change_level(name: String) -> void:
	if _level:
		call_deferred("remove_child", _level)
		_level.queue_free()
	
	_level = load(name).instantiate()
	call_deferred("add_child", _level)
	
	var spawn = _level.find_child("PlayerSpawn") as Node2D
	_player.position = spawn.position
