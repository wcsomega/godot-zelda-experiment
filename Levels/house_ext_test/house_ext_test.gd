extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		print("entered house")
		EventBus.change_level("res://Levels/house_int_test/house_int_test.tscn")
