extends StaticBody2D

func on_interact():
	$CollisionShape2D.set_deferred("disabled", true)
	$Sprite2D.visible = false
	$Sprite2D2.visible = true
	
	if randf() < 0.50:
		var heart = preload("res://heart_drop.tscn").instantiate()
		heart.position = position
	
		get_parent().add_child(heart)
