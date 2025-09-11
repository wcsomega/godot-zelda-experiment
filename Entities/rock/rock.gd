extends StaticBody2D

func on_interact(player: Player) -> void:
	var carried_rock = preload("res://Entities/rock/rock_carried.tscn").instantiate()
	$CollisionShape2D.set_deferred("disabled", true)
	$Sprite2D.visible = false
	$Sprite2D2.visible = true
	player.start_carry(carried_rock);
