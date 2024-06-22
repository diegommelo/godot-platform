extends Node
class_name CharacterStateMachine

@export var character : CharacterBody2D
@export var animation_tree : AnimationTree
@export var current_state : State

var states: Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.character = character
			child.playback = animation_tree["parameters/playback"]
			child.transitioned.connect(on_child_transitioned)
		else:
			push_warning("Child " + child.name + "is not a State ofr CharacterStateMachine")
	
	current_state.on_enter()

func _process(delta: float) -> void:
	current_state.state_process(delta)

func _physics_process(delta: float) -> void:
	current_state.state_physics_process(delta)
	
func _input(event: InputEvent) -> void:
	current_state.state_input(event)
	
func on_child_transitioned(new_state_name: StringName) -> void:
	var new_state = states.get(new_state_name)
	
	if new_state != null:
		if new_state != current_state:
			current_state.on_exit()
			new_state.on_enter()
			current_state = new_state
	else:
		push_warning("Called transition on a state that does not exist")
	
func can_move() -> bool:
	return current_state.can_move