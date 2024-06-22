class_name GroundState
extends State

@export var jump_velocity : float = -250.0
@export var air_state : State
@export var jump_animation : String = "jump"

func state_physics_process(delta):
	if not character.is_on_floor():
		transitioned.emit("AirState", {'from_state': name})

func state_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		jump()

func jump():
	character.velocity.y = jump_velocity
	transitioned.emit("AirState")
	playback.travel(jump_animation)
