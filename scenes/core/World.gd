extends Node2D

func _ready():
	var level = load(MNSceneManager.get_level_scene())
	var scene = level.instantiate()
	add_child(scene)
