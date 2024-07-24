class_name NSceneManager
extends Node

@export var Scenes : Dictionary = {}

var current_scene : String = ""
var current_level : String = ""

func add_scene(scene_alias: String, scene_path: String) -> void:
	Scenes[scene_alias] = scene_path

func remove_scene(scene_alias: String) -> void:
	Scenes.erase(scene_alias)
	
func switch_scene(scene_alias: String) -> void:
	get_tree().change_scene_to_file(Scenes[scene_alias])

func restart_scene() -> void:
	get_tree().reload_current_scene()
	
func quit_game() -> void:
	get_tree().quit()
	
func set_current_level(level_alias: String) -> void:
	current_level = level_alias
	
func get_level_scene() -> String:
	return Scenes.LevelList.get(current_level)
	
func _ready() -> void:
	var main_scene : StringName = ProjectSettings.get_setting("application/run/main_scene")
	current_scene = Scenes.find_key(main_scene)
