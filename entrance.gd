class_name Entrance extends Area2D

@export var target_level: String
@export var exit_name: String

func on_player_enter(body: Node2D) -> void:
	if body is Player:
		EventBus.change_level(target_level, exit_name)
