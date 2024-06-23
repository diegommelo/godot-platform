class_name AirState
extends State

@export var double_jump_modifier : float = 0.8
@export var double_jump_animation : String = "double_jump"
@export var landing_animation : String = "landing"

var has_double_jump = true

func state_physics_process(delta):
	apply_air_resistance(delta)
	handle_air_acceleration(delta)
	
	if character.is_on_floor():
		transitioned.emit("LandingState", {})
		
func state_input(event : InputEvent):
	var has_jumped = emitted_args.get("has_jumped")

	if event.is_action_pressed("jump") and has_double_jump and has_jumped:
			double_jump()

func on_enter():
	playback.travel("jump_start")

func on_exit():
	has_double_jump = true
	if from_state == 'GroundState':
		playback.travel(landing_animation)

func double_jump():
	character.velocity.y = character.movement_data.jump_velocity * double_jump_modifier
	playback.travel(double_jump_animation)
	has_double_jump = false

func apply_air_resistance(delta):
	character.velocity.x = move_toward(character.velocity.x, 0, character.movement_data.air_resistance * delta)
	
func handle_air_acceleration(delta):
	character.velocity.x = move_toward(character.velocity.x, character.movement_data.speed * character.direction.x, character.movement_data.air_acceleration * delta)
