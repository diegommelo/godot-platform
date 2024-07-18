class_name WallState
extends State

func on_enter() -> void:
	wall_normal = character.get_wall_normal()
	character.velocity.x = 0

func state_physics_process(delta) -> void:
	if from_state == "AirState":
		animation_player.play(character.animations.wall_jump)
		character.sprite_2d.flip_h = (wall_normal.x > 0)

		if (wall_normal.x > 0 and Input.is_action_pressed("move_left")) or (wall_normal.x < 0 and Input.is_action_pressed("move_right")):
			apply_wall_slide(delta)
			
		if (wall_normal.x > 0 and Input.is_action_just_released("move_left")) or (wall_normal.x < 0 and Input.is_action_just_released("move_right")):
			transitioned.emit("AirState", { "from_state": name, "wall_direction": wall_normal.x })

	if character.is_on_floor():
		transitioned.emit("GroundState", {})

func state_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		character.jump()

func apply_wall_slide(delta) -> void:
	character.velocity.y = character.movement_data.wall_sliding * delta;
