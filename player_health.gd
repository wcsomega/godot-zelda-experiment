extends Node

signal health_changed(new_health: int)
signal max_hearts_changed(new_max_hearts: int)

var max_hearts: int = 3:
	get:
		return max_hearts
	set(value):
		max_hearts = clamp(value, 0, 20)
		health = clamp(health, 0, max_hearts * 4)
		max_hearts_changed.emit(max_hearts)
		health_changed.emit(health)

var health: int = 12:
	get:
		return health
	set(value):
		health = clamp(value, 0, max_hearts * 4)
		health_changed.emit(health)
