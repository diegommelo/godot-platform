class_name State
extends Node

var character : CharacterBody2D
var animation_player : AnimationPlayer
var from_state : String = ""
var emitted_args : Dictionary = {}

signal transitioned(new_state_name: StringName)

func state_input(_event: InputEvent) -> void:
	pass
	
func state_process(_delta: float) -> void:
	pass
	
func state_physics_process(_delta: float) -> void:
	pass
	
func on_enter() -> void:
	pass

func on_exit() -> void:
	pass
