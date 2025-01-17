extends Node2D

var _level: Node2D
var _player: Node2D

func _ready() -> void:
	EventBus.level_changed.connect(change_level)
	change_level("res://Levels/house_ext_test/house_ext_test.tscn")

func change_level(name: String) -> void:
	if _level:
		call_deferred("remove_child", _level)
		_level.queue_free()
	
	_level = load(name).instantiate()
	call_deferred("add_child", _level)
	
	if _player:
		_player.queue_free()
	
	_player = load("res://Entities/player_char/player_char.tscn").instantiate()
	var spawn = _level.find_child("PlayerSpawn") as Node2D
	_player.position = spawn.position
	$PlayerCam.target = _player
	call_deferred("add_child", _player)
