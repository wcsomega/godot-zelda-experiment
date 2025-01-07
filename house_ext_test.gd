extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("entered house")
		get_tree().change_scene_to_file("res://house_int_test.tscn")
