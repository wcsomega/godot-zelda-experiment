extends Sprite2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.on_heal(4)
		queue_free()

func _on_timer_timeout() -> void:
	queue_free()
