extends StaticBody2D

func on_interact(player: Player):
	$CollisionShape2D.set_deferred("disabled", true)
	$Sprite2D.visible = false
	$Sprite2D2.visible = true
	player.start_carry(preload("res://Entities/shrub/shrub_carry.tscn").instantiate())
	
	if randf() < 0.50:
		var heart = preload("res://heart_drop.tscn").instantiate()
		heart.position = position
	
		get_parent().add_child(heart)
