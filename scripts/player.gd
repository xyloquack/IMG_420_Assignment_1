extends CharacterBody2D

signal kill
signal bounce
signal boost
signal win

@export var max_speed: float
@export var acceleration: float
@export var friction: float
@export var gravity: float
@export var jump_speed: float
@export var wall_jump_off_speed: float

var world
var direction = 0
var on_wall = false
var was_on_wall = false

func _ready():
	world = get_tree().get_root().get_node("World")

func get_direction(delta):
	on_wall = is_on_wall()
	
	if $WallJumpTimer.is_stopped():
		direction = 0
		
		if Input.is_action_pressed("right"):
			direction += 1
			
		if Input.is_action_pressed("left"):
			direction -= 1
			
	var current_friction = friction * abs(velocity.x) / max_speed
	var current_acceleration = acceleration
	var current_gravity = gravity
	
	if abs(velocity.x) > max_speed:
		current_friction = (abs(velocity.x) / (max_speed)) * (acceleration - friction) + friction
	else:
		current_friction = friction
	
	if not is_on_floor():
		current_acceleration /= 2
		current_friction /= 2
	else:
		$CoyoteTimer.start()
		
	if is_on_wall_only():
		current_gravity /= 2
	elif Input.is_action_pressed("up"):
		current_gravity /= 1.3
		
	velocity.x += direction * current_acceleration * delta
	var current_moving_direction = 1 if (velocity.x > 0) else -1
	velocity.x -= current_moving_direction * current_friction * delta
	var new_moving_direciton = 1 if (velocity.x > 0) else -1
	if current_moving_direction != new_moving_direciton:
		velocity.x = 0
	velocity.y += current_gravity * delta
	
	if on_wall and not was_on_wall:
		velocity.y = 0
	
	if Input.is_action_just_pressed("up") and (is_on_floor() or not $CoyoteTimer.is_stopped()) and not is_on_wall_only():
		velocity += Vector2.UP * jump_speed
		
	if Input.is_action_just_pressed("up") and is_on_wall_only():
		velocity += Vector2.UP * jump_speed
		
		if velocity.y > -jump_speed:
			velocity.y = -jump_speed
			
		velocity += Vector2.RIGHT * get_wall_normal() * wall_jump_off_speed
		direction = get_wall_normal().x
		$WallJumpTimer.start()
		
	was_on_wall = on_wall
	
func change_sprite():
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	if velocity.x == 0:
		$AnimatedSprite2D.animation = "idle"
	else:
		$AnimatedSprite2D.animation = "running"

func _physics_process(delta):
	get_direction(delta)
	change_sprite()
	move_and_slide()

func _on_kill() -> void:
	world.emit_signal("death")

func _on_bounce() -> void:
	if $BounceCooldown.is_stopped():
		$BounceCooldown.start()
		velocity.y = -1500
		
func _on_boost(boost_direction) -> void:
	if $BoostCooldown.is_stopped():
		$BoostCooldown.start()
		velocity.x += 4000 * boost_direction
		
func _on_win():
	print("Win!")
	world.emit_signal("win")
