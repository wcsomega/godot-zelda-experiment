extends CharacterBody2D 

enum Direction {
	UP,
	DOWN,
	LEFT,
	RIGHT,
}

var speed = 90

@onready var sprite = $AnimatedSprite2D
@onready var ray = $RayCast2D
var last_direction = Direction.DOWN
var last_held_dir = Direction.DOWN
var is_held_dir = false

func _process(_delta):
	if Input.is_action_just_pressed("interact") && ray.is_colliding():
		var o = ray.get_collider()
		if o.has_method("on_interact"):
			o.on_interact()
		#var ray_params = PhysicsRayQueryParameters2D.create(position, position + Vector2(0, 16))
		#var ray_result = get_world_2d().direct_space_state.intersect_ray(ray_params)
		#if ray_result && ray_result.collider.has_method("on_interact"):
		#	ray_result.collider.on_interact()
	
	
	if is_held_dir:
		if last_held_dir == Direction.UP && !Input.is_action_pressed("move_up"):
			is_held_dir = false
		elif last_held_dir == Direction.DOWN && !Input.is_action_pressed("move_down"):
			is_held_dir = false
		elif last_held_dir == Direction.LEFT && !Input.is_action_pressed("move_left"):
			is_held_dir = false
		elif last_held_dir == Direction.RIGHT && !Input.is_action_pressed("move_right"):
			is_held_dir = false
	
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
	
	match last_direction:
		Direction.UP:
			ray.target_position = Vector2.UP * 8.5
		Direction.DOWN:
			ray.target_position = Vector2.DOWN * 8.5
		Direction.LEFT:
			ray.target_position = Vector2.LEFT * 8.5
		Direction.RIGHT:
			ray.target_position = Vector2.RIGHT * 8.5
 
