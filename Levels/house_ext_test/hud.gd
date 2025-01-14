extends CanvasLayer

var target_health: int
var shown_health: int
var max_hearts: int
var ui_hearts = []

func change_health(new_health: int) -> void:
	target_health = clamp(new_health, 0, max_hearts * 4)

func change_max_hearts(new_max_hearts: int) -> void:
	max_hearts = clamp(new_max_hearts, 0, 20)
	target_health = clamp(target_health, 0, max_hearts * 4)
	
	for heart in ui_hearts:
		heart.free()
	ui_hearts.clear()
	
	for i in max_hearts:
		var ui_heart = preload("res://HUD/HealthBar/ui_heart.tscn").instantiate()
		ui_hearts.push_back(ui_heart)
		var x = i % 10
		var y = i / 10
		ui_heart.position = Vector2(x*8, y*8)
		add_child(ui_heart)

func _process(delta: float) -> void:
	if target_health > shown_health:
		shown_health += 1
	if target_health < shown_health:
		shown_health -= 1
	for i in ui_hearts.size():
		var ui_heart = ui_hearts[i]
		ui_heart.amount = shown_health - (i * 4)
