extends State
class_name LandingState

@export var landing_animation_name : String = "landing"
@export var ground_state : State


func state_physics_process(delta):
	if character.is_on_floor(): 
		transitioned.emit("GroundState", {})

#func _on_animation_tree_animation_finished(anim_name):
	#if anim_name == landing_animation_name:
		#transitioned.emit("GroundState", {})  

