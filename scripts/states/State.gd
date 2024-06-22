class_name State
extends Node

@export var can_move : bool = true

var character : CharacterBody2D
var playback : AnimationNodeStateMachinePlayback
#var next_state : State

signal transitioned(new_state_name: StringName)

func state_input(event) -> void:
	pass
	
func state_process(delta: float) -> void:
	pass
	
func state_physics_process(delta: float) -> void:
	pass
	
func on_enter() -> void:
	pass

func on_exit() -> void:
	pass
