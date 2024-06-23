class_name GroundState
extends State

@export var jump_animation : String = "jump"
@export var coyote_jump_timer : Timer
var has_jumped : bool = false

func state_physics_process(delta):
	if not character.is_on_floor() and has_jumped == false and character.velocity.y >= 80:
		transitioned.emit("AirState", { 'from_state': name, 'has_jumped': has_jumped })
		
	if character.is_on_floor():
		has_jumped = false
		walk(delta)
	
func state_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		if character.is_on_floor():
			print('pulou')
			jump()
		elif not character.is_on_floor() and character.velocity.y <= 80:
			print('coyte')
			jump()

#func on_exit():
	#print('saiu do ground')
	
func jump():
	character.velocity.y = character.movement_data.jump_velocity
	has_jumped = true
	transitioned.emit("AirState", { 'from_state': name, 'has_jumped': has_jumped })
	playback.travel(jump_animation)
	
func walk(delta):
	print(character.direction.x)
	if character.direction.x != 0 :
		character.velocity.x = character.direction.x * character.movement_data.speed
	else:
		character.velocity.x = move_toward(character.velocity.x, 0, character.movement_data.friction * delta)
