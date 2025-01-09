extends StaticBody2D

func on_interact():
	$CollisionShape2D.set_deferred("disabled", true)
	$Sprite2D.visible = false
	$Sprite2D2.visible = true
