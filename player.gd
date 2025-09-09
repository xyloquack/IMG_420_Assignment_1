extends CharacterBody2D

@export var max_speed: float
@export var acceleration: float
@export var friction: float
@export var gravity: float
@export var jump_speed: float

func get_direction(delta):
	var direction = 0
	if Input.is_action_pressed("right"):
		direction += 1
	if Input.is_action_pressed("left"):
		direction -= 1
	var current_friction = friction
	var current_acceleration = acceleration
	if not is_on_floor():
		current_acceleration /= 2
	if abs(velocity.x) > max_speed:
		current_friction += acceleration
	velocity += Vector2.RIGHT * direction * current_acceleration * delta
	velocity -= Vector2(velocity.normalized().x, 0) * current_friction * delta
	velocity += Vector2.DOWN * gravity * delta
	
	if Input.is_action_pressed("up") and is_on_floor():
		velocity += Vector2.UP * jump_speed

func _physics_process(delta):
	get_direction(delta)
	move_and_slide()
