class_name GroundState
extends State

@export var jump_animation : String = "jump"
var has_jumped : bool = false

func state_physics_process(delta) -> void:
	if character.is_on_floor():
		has_jumped = false
		walk(delta)
		if character.direction.x == 0:
			apply_friction(delta)

	if not character.is_on_floor() and has_jumped == false and character.velocity.y >= 80:
		transitioned.emit("AirState", { 'from_state': name, 'has_jumped': has_jumped })
		
		
func state_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		if character.is_on_floor():
			#print('frog normal')
			jump()
		elif not character.is_on_floor() and character.velocity.y <= 40:
			#print('frog coyote')
			jump()


func jump() -> void:
	character.velocity.y = character.movement_data.jump_velocity
	has_jumped = true
	playback.travel(jump_animation)
	transitioned.emit("AirState", { 'from_state': name, 'has_jumped': has_jumped })
	
func walk(delta) -> void:
	if character.direction.x != 0 :
		#character.velocity.x = character.direction.x * character.movement_data.speed
		character.velocity.x = move_toward(character.velocity.x, character.movement_data.speed * character.direction.x, character.movement_data.acceleration * delta)
	else:
		character.velocity.x = move_toward(character.velocity.x, 0, character.movement_data.speed * delta)

func apply_friction(delta) -> void:
	character.velocity.x = move_toward(character.velocity.x, 0, character.movement_data.friction * delta)

func handle_acceleration(delta) -> void:
	character.velocity.x = move_toward(character.velocity.x, character.movement_data.speed * character.direction.x, character.movement_data.acceleration * delta)
	
	
