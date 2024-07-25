extends GridContainer

var level_box = preload("res://scenes/ui/LevelBox.tscn")

func _ready():
	for i in 6:
		var level = level_box.instantiate()
		level.connect("level_selected", _on_level_selected)
		add_child(level)

func _on_level_selected(level):
	var scene_level = "Level" + str(level)
	MNSceneManager.set_current_level(scene_level)
	MNSceneManager.switch_scene("World")
