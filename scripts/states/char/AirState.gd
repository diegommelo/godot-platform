extends State
class_name AirState

@export var landing_state : State
@export var ground_state : State
@export var double_jump_modifier : float = 0.8
@export var double_jump_animation : String = "double_jump"
@export var landing_animation : String = "landing"

var has_double_jump = true

func state_physics_process(delta):
	if character.is_on_floor():
		transitioned.emit("LandingState")
		
func state_input(event : InputEvent):
	if event.is_action_pressed("jump") and has_double_jump:
		double_jump()

func on_exit():
	playback.travel(landing_animation)
	has_double_jump = true

func double_jump():
	character.velocity.y = ground_state.jump_velocity * double_jump_modifier
	playback.travel(double_jump_animation)
	has_double_jump = false

