extends CharacterBody2D 

enum Direction {
	UP,
	DOWN,
	LEFT,
	RIGHT,
}

var speed = 90
const INTERACT_DISTANCE = 8.5

var health = 20; #each heart is 4 hp so this is 10 hearts
var max_hearts = 10;

signal health_changed(new_health: int)
signal max_hearts_changed(new_max_hearts: int)

@onready var sprite = $AnimatedSprite2D
@onready var interact_ray = $RayCast2D
var last_direction = Direction.DOWN
var last_held_dir = Direction.DOWN
var is_held_dir = false

func on_heal(amount: int):
	health = clamp(health + amount, 0, max_hearts * 4)
	health_changed.emit(health)

func _ready() -> void:
	max_hearts_changed.emit(max_hearts)
	health_changed.emit(health)

func _process(_delta):
	if Input.is_action_just_pressed("max_hp_up"):
		max_hearts = clamp(max_hearts + 1, 0, 20)
		health = clamp(health, 0, max_hearts * 4)
		max_hearts_changed.emit(max_hearts)
		health_changed.emit(health)
	if Input.is_action_just_pressed("max_hp_down"):
		max_hearts = clamp(max_hearts - 1, 0, 20)
		health = clamp(health, 0, max_hearts * 4)
		max_hearts_changed.emit(max_hearts)
		health_changed.emit(health)
	
	#Test if there is an interactable object in front of the player
	#if they are pressing the interact button, call the on_interact
	#method on the interactable object
	if Input.is_action_just_pressed("interact") && interact_ray.is_colliding():
		var o = interact_ray.get_collider()
		if o.has_method("on_interact"):
			o.on_interact()
	
	#This checks if a previously held direction has been released
	if is_held_dir:
		if last_held_dir == Direction.UP && !Input.is_action_pressed("move_up"):
			is_held_dir = false
		elif last_held_dir == Direction.DOWN && !Input.is_action_pressed("move_down"):
			is_held_dir = false
		elif last_held_dir == Direction.LEFT && !Input.is_action_pressed("move_left"):
			is_held_dir = false
		elif last_held_dir == Direction.RIGHT && !Input.is_action_pressed("move_right"):
			is_held_dir = false
	
	#When moving, we want the player character to always face the first held down
	#direction even when another direction gets pressed. For example, if the player
	#first holds up and then also holds right, we want the player character to face
	#up until the up button is released.
	var movement = Vector2.ZERO
	var is_walking = false
	if Input.is_action_pressed("move_up"):
		movement += Vector2.UP
		is_walking = true
		if !is_held_dir:
			last_direction = Direction.UP
			last_held_dir = Direction.UP
			is_held_dir = true
	if Input.is_action_pressed("move_down"):
		movement += Vector2.DOWN
		is_walking = true
		if !is_held_dir:
			last_direction = Direction.DOWN
			last_held_dir = Direction.DOWN
			is_held_dir = true
	if Input.is_action_pressed("move_right"):
		movement += Vector2.RIGHT
		is_walking = true
		if !is_held_dir:
			last_direction = Direction.RIGHT
			last_held_dir = Direction.RIGHT
			is_held_dir = true
	if Input.is_action_pressed("move_left"):
		movement += Vector2.LEFT
		is_walking = true
		if !is_held_dir:
			last_direction = Direction.LEFT
			last_held_dir = Direction.LEFT
			is_held_dir = true
	
	velocity = movement.normalized() * speed
	move_and_slide()
	
	#Play the correct animation based on whether player character is walking
	#or not and which direction they're facing
	if is_walking:
		match last_direction:
			Direction.RIGHT:
				sprite.play("walk_right")
			Direction.LEFT:
				sprite.play("walk_left")
			Direction.UP:
				sprite.play("walk_up")
			Direction.DOWN:
				sprite.play("walk_down")
	else:
		match last_direction:
			Direction.RIGHT:
				sprite.play("idle_right")
			Direction.LEFT:
				sprite.play("idle_left")
			Direction.UP:
				sprite.play("idle_up")
			Direction.DOWN:
				sprite.play("idle_down")
	
	#Set the direction of the interaction ray based on direction player char is facing
	match last_direction:
		Direction.UP:
			interact_ray.target_position = Vector2.UP * INTERACT_DISTANCE
		Direction.DOWN:
			interact_ray.target_position = Vector2.DOWN * INTERACT_DISTANCE
		Direction.LEFT:
			interact_ray.target_position = Vector2.LEFT * INTERACT_DISTANCE
		Direction.RIGHT:
			interact_ray.target_position = Vector2.RIGHT * INTERACT_DISTANCE
 
