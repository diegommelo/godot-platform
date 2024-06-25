class_name AirState
extends State

@export var fall_animation : String = "Fall"

var has_double_jump : bool = true

func state_physics_process(delta):
	if character.direction == 0:
		apply_air_resistance(delta)
	if character.direction != 0:
		handle_air_acceleration(delta)
	
	if character.is_on_floor():
		transitioned.emit("GroundState", {})
	
	if not character.is_on_floor():
	
		if character.is_on_wall_only():
			transitioned.emit("WallState", {})
			
		if Input.is_action_just_released("jump") and character.velocity.y < character.movement_data.jump_velocity / 2:
			#print('frog small')
			character.velocity.y = character.movement_data.jump_velocity / 2
		
func state_input(event : InputEvent):
	var has_jumped = emitted_args.get("has_jumped")
	if event.is_action_pressed("jump") and has_double_jump and has_jumped:
		double_jump()

func on_enter():
	animation_player.play(character.animations.jump)

func on_exit():
	has_double_jump = true

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
