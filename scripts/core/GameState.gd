extends Node

var game_time: float = 0.0
var game_started: bool = false
var game_time_stopped: bool = true
var current_response: Array = []

#var current_level: String
#var next_level: String
#
#func set_current_level(level: String) -> void:
	#current_level = level
	#
#func set_next_level(level: String) -> void:
	#next_level = level
#
#func get_next_level() -> String:
	#return next_level
func set_current_response(gs_response: Array) -> void:
	current_response = gs_response
	
func clear_current_response() -> void:
	current_response = []
	
func get_current_response() -> Array:
	return current_response

func start_game() -> void:
	game_started = true
	game_time_stopped = false

func stop_game() -> void:
	game_started = false
	game_time_stopped = true
