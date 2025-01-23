extends Area2D

@export var target_level: String

func on_player_enter(body: Node2D) -> void:
	if body is Player:
		EventBus.change_level(target_level)
