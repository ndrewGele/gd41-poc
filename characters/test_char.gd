extends CharacterBody3D

@export var speed = 20
@export var fall_acceleration = 150
@export var jump_impulse = 40
@export var max_jumps = 2

var target_velocity = Vector3.ZERO
var remaining_jumps = max_jumps

func _physics_process(delta):

	var direction = Vector3.ZERO

	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	
	if is_on_floor():
		remaining_jumps = max_jumps
		
	if remaining_jumps > 0 and Input.is_action_just_pressed("move_up"):
		target_velocity.y = jump_impulse
		remaining_jumps -= 1
		if direction != Vector3.ZERO:
			$Pivot.look_at(position + direction, Vector3.UP)
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		if is_on_floor():
			$Pivot.look_at(position + direction, Vector3.UP)

	# Ground Velocity
	target_velocity.x = direction.x * speed

	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	# Moving the Character
	velocity = target_velocity
	move_and_slide()
