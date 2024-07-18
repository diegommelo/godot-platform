extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : float
@export var movement_data : PlayerMovementData
@export var animations : AnimationNames
@onready var sprite_2d : Sprite2D = $Sprite2D
@onready var state_machine : CharacterStateMachine = $ChararacterStateMachine

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
