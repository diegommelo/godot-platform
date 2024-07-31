class_name WallState
extends State

var wall_normal: Vector2

func on_enter() -> void:
	character.velocity.x = 0
	wall_normal = character.get_wall_normal()
	character.sprite_2d.flip_h = (wall_normal.x < 0)

func state_physics_process(delta) -> void:
	if from_state == "AirState":
		character.animation_player.play(character.animations.wall_jump)
		#if (wall_normal.x > 0 and Input.is_action_pressed("move_left")) or (wall_normal.x < 0 and Input.is_action_pressed("move_right")):
			#apply_wall_slide(delta)
					
	if character.is_on_floor():
		transitioned.emit("GroundState", {})

	if !character.is_on_wall():
		if from_state == "AirState":
			transitioned.emit("AirState", { 'from_state': "WallState" })
			

func state_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and character.previous_wall_normal != wall_normal.x:
		#character.jump(wall_normal.x)
		character.wall_jump(wall_normal.x)
	#if event.is_action_pressed("move_left") and wall_normal.x < 0:
		#character.velocity.x = -20
	#if event.is_action_pressed("move_right") and wall_normal.x > 0:
		#character.velocity.x = 20		

func apply_wall_slide(delta: float) -> void:
	character.velocity.y = character.movement_data.wall_sliding * delta;

