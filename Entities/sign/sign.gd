extends StaticBody2D

@export var text: String = "Test"

var textbox_scene: PackedScene

func _ready() -> void:
	textbox_scene = preload("res://textbox.tscn")

func on_interact():
	print("read sign: %s" % text)
	var tb = textbox_scene.instantiate()
	add_child(tb)
