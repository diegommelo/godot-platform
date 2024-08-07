extends CharacterBody2D

@export var movement_data : PlayerMovementData
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var air_jump = false
var was_wall_normal = Vector2.ZERO
var just_wall_jumped = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var coyote_jump_timer = $CoyoteJumpTimer
@onready var wall_jump_timer = $WallJumpTimer
@onready var starting_position = global_position

func _physics_process(delta):
	var input_axis = Input.get_axis("ui_left", "ui_right")

	apply_gravity(delta)
	handle_wall_jump()
	handle_jump()
	handle_acceleration(input_axis, delta)
	handle_air_acceleration(input_axis, delta)
	apply_friction(input_axis, delta)
	apply_air_resistance(input_axis, delta)
	var was_on_floor = is_on_floor()
	var was_on_wall = is_on_wall_only()
	if was_on_wall:
		was_wall_normal = get_wall_normal()
	move_and_slide()
	var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
	if just_left_ledge:
		coyote_jump_timer.start()
	just_wall_jumped = false
	var just_left_wall = was_on_wall and not is_on_wall()
	if just_left_wall:
		wall_jump_timer.start()
	update_animations(input_axis)
	
	
func handle_acceleration(input_axis, delta):
	if not is_on_floor(): return
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, movement_data.speed * input_axis, movement_data.acceleration * delta)
		
func handle_air_acceleration(input_axis, delta):
	if is_on_floor(): return
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, movement_data.speed * input_axis, movement_data.air_acceleration * delta)

func handle_jump():
	if is_on_floor(): air_jump = true
	
	# Coyote jump
	if is_on_floor() or coyote_jump_timer.time_left > 0.0:
		if Input.is_action_just_pressed("jump"):
			#print('player normal')
			velocity.y = movement_data.jump_velocity
			coyote_jump_timer.stop()
			
	elif not is_on_floor():
		# Small jump
		if Input.is_action_just_released("jump") and velocity.y < movement_data.jump_velocity / 2:
			velocity.y = movement_data.jump_velocity / 2
			#print('player small')
		# Double jump	
		if Input.is_action_just_pressed("jump") and air_jump and not just_wall_jumped:
			velocity.y = movement_data.jump_velocity * movement_data.double_jump_modifier
			air_jump = false
			#print('player double')

func handle_wall_jump():
	if not is_on_wall_only() and wall_jump_timer.time_left <= 0.0: return
	var wall_normal = get_wall_normal()
	if wall_jump_timer.time_left > 0.0:
		wall_normal = was_wall_normal
	if Input.is_action_just_pressed("jump"):
		velocity.x = wall_normal.x * movement_data.speed
		velocity.y = movement_data.jump_velocity * movement_data.double_jump_modifier
		animated_sprite.flip_h = false if wall_normal.x == 1 else true
		just_wall_jumped = true
		#print('just_wall_jumped ', just_wall_jumped)
		

func update_animations(input_axis):
	if input_axis != 0:
		animated_sprite.flip_h = (input_axis < 0)
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")
		
	if not is_on_floor():
		animated_sprite.play("jump")

func apply_air_resistance(input_axis, delta):
	if input_axis == 0 and not is_on_floor():
		velocity.x = move_toward(velocity.x, 0, movement_data.air_resistance * delta)
		
func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * movement_data.gravity_scale * delta
			
func apply_friction(input_axis, delta):
	if input_axis == 0 and is_on_floor():
		#print('fricion')
		velocity.x = move_toward(velocity.x, 0, movement_data.friction * delta)

func _on_hazard_detector_area_entered(area):
	global_position = starting_position
