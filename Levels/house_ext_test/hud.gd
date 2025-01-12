extends CanvasLayer

var target_health = 4
var shown_health: int
var max_hearts = 15
var ui_hearts = []

func _ready() -> void:
	for i in max_hearts:
		var ui_heart = preload("res://HUD/HealthBar/ui_heart.tscn").instantiate()
		ui_hearts.push_back(ui_heart)
		var x = i % 10
		var y = i / 10
		ui_heart.position = Vector2(x*8, y*8)
		add_child(ui_heart)
	shown_health = target_health
	change_health(target_health)

func change_health(new_health: int) -> void:
	target_health = clamp(new_health, 0, max_hearts * 4)

func _process(delta: float) -> void:
	if target_health > shown_health:
		shown_health -= 1
	if target_health < shown_health:
		shown_health -= 1
	for i in ui_hearts.size():
		var ui_heart = ui_hearts[i]
		ui_heart.amount = shown_health - (i * 4)
	if Input.is_action_just_pressed("hp_up"):
		change_health(target_health + 16)
	if Input.is_action_just_pressed("hp_down"):
		change_health(target_health - 16)
