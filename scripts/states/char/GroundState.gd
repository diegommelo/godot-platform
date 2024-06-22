class_name GroundState
extends State

@export var air_state : State
@export var jump_animation : String = "jump"

func state_physics_process(delta):
	if not character.is_on_floor():
		transitioned.emit("AirState", {'from_state': name})
		
	if character.is_on_floor():
		walk(delta)

func state_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		jump()

func jump():
	character.velocity.y = character.movement_data.jump_velocity
	transitioned.emit("AirState")
	playback.travel(jump_animation)
	
func walk(delta):
	if character.direction.x != 0 :
		character.velocity.x = character.direction.x * character.movement_data.speed
	else:
		character.velocity.x = move_toward(character.velocity.x, 0, character.movement_data.friction * delta)
