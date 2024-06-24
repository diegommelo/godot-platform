extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO
@export var movement_data : PlayerMovementData
@onready var sprite_2d : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $ChararacterStateMachine

func _ready() -> void:
	animation_tree.active = true

func _physics_process(delta) -> void:
	direction = Input.get_vector("move_left", "move_right", "jump", "ui_down")
	
	apply_gravity(delta)
	move_and_slide()
	update_facing_direction()
	update_animation_parameters()
	
func update_animation_parameters():
	animation_tree.set("parameters/Move/blend_position", direction.x)
	
func update_facing_direction() -> void:
	if direction.x > 0:
		sprite_2d.flip_h = false 
	elif direction.x < 0:
		sprite_2d.flip_h = true
	
func apply_gravity(delta) -> void:
	if not is_on_floor():
		velocity.y += gravity * movement_data.gravity_scale * delta
