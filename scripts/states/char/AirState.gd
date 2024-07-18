class_name AirState
extends State

var has_double_jump : bool = true

func on_enter():
	animation_player.play(character.animations.jump)
		
func on_exit():
	has_double_jump = true

func state_physics_process(delta):
	if from_state == "WallState":
		var wall_direction = emitted_args.get("wall_direction")
		character.sprite_2d.flip_h = (wall_direction < 0)
		
	if character.direction == 0:
		apply_air_resistance(delta)
	if character.direction != 0:
		handle_air_acceleration(delta)
			
	if Input.is_action_just_released("jump") and character.velocity.y < character.movement_data.jump_velocity / 2:
		#print('frog small')
		character.velocity.y = character.movement_data.jump_velocity / 2
		
	if character.is_on_wall_only():
		var jump_direction = Input.get_axis("move_left", "move_right")
		var wall_normal = character.get_wall_normal()

		if jump_direction != 0 and jump_direction != wall_normal.x:
			transitioned.emit("WallState", { "from_state": name })
			
	if character.is_on_floor_only():
		transitioned.emit("GroundState", {})
		
func state_input(event : InputEvent):
	var has_jumped = emitted_args.get("has_jumped")
	if event.is_action_pressed("jump") and has_double_jump and has_jumped:
		double_jump()

func double_jump():
	character.velocity.y = character.movement_data.jump_velocity * character.movement_data.double_jump_modifier
	animation_player.play(character.animations.double_jump)
	has_double_jump = false

func apply_air_resistance(delta):
	#print('air resistance')
	character.velocity.x = move_toward(character.velocity.x, 0, character.movement_data.air_resistance * delta)
	
func handle_air_acceleration(delta):
	#print('air accel')
	character.velocity.x = move_toward(character.velocity.x, character.movement_data.speed * character.direction, character.movement_data.air_acceleration * delta)
