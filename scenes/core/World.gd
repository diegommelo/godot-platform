extends Node2D

func _ready():
	var level = load(MNSceneManager.get_level_scene())
	var scene = level.instantiate()
	add_child(scene)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and GameState.game_started == true:
		get_node("Menus/PauseScreen").visible = true
		GameState.pause_game()
		EventBus.pause_game.emit()
