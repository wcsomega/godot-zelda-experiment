extends Node2D

var _level: Node2D
@onready var _player: Node2D = $Player

func _ready() -> void:
	EventBus.level_changed.connect(change_level)
	change_level("res://Levels/house_ext_test/house_ext_test.tscn", "default_spawn")

func change_level(level_name: String, exit_name: String) -> void:
	if _level:
		call_deferred("remove_child", _level)
		_level.queue_free()
	
	_level = load(level_name).instantiate()
	call_deferred("add_child", _level)
	
	#var spawn = _level.find_child("PlayerSpawn") as Node2D
	#_player.position = spawn.position
	var spawns = _level.find_children(exit_name, "Exit")
	assert(spawns.size() != 0)
	
	_player.position = spawns[0].position
	
	
