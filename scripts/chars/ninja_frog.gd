extends CharacterBody2D

@export var movement_data : PlayerMovementData
@export var animations : AnimationNames
@onready var sprite_2d : Sprite2D = $Sprite2D
@onready var state_machine : CharacterStateMachine = $ChararacterStateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_jumped: bool =  false
var direction : float

func _physics_process(delta) -> void:
	direction = Input.get_axis("move_left", "move_right")
	apply_gravity(delta)
	move_and_slide()
	update_facing_direction()
	
func update_facing_direction() -> void:
	if direction > 0:
		sprite_2d.flip_h = false 
	elif direction < 0:
		sprite_2d.flip_h = true
	
func apply_gravity(delta) -> void:
	if not is_on_floor():
		velocity.y += gravity * movement_data.gravity_scale * delta

func jump() -> void:
	velocity.y = movement_data.jump_velocity
	if state_machine.current_state.name == "WallState":
		if direction > 0:
			velocity.x = -movement_data.wall_jump_pushback
		if direction < 0:
			velocity.x = movement_data.wall_jump_pushback

	has_jumped = true
	animation_player.play(animations.jump)
	state_machine.current_state.transitioned.emit("AirState", { 'from_state': name, 'has_jumped': has_jumped })

func walk(delta) -> void:
	if direction != 0 :
		#character.velocity.x = character.direction * character.movement_data.speed
		velocity.x = move_toward(velocity.x, movement_data.speed * direction, movement_data.acceleration * delta)
		animation_player.play(animations.run)
	else:
		animation_player.play(animations.idle)
		#character.velocity.x = move_toward(character.velocity.x, 0, character.movement_data.speed * delta)
		velocity.x = move_toward(velocity.x, 0, movement_data.friction * delta)
