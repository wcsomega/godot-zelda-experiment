extends CanvasLayer

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("hp_up"):
		$UIHeart.amount += 1
	if Input.is_action_just_pressed("hp_down"):
		$UIHeart.amount -= 1
