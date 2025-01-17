extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		#get_tree().call_deferred("change_scene_to_file", "res://Levels/house_ext_test/house_ext_test.tscn")
		EventBus.change_level("res://Levels/house_ext_test/house_ext_test.tscn")
