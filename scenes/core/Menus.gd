extends MarginContainer

enum child_scenes {COLOR_RECT, HEADER, PAUSE_SCREEN}

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if GameState.game_paused == true:
			get_tree().paused = false
			GameState.unpause_game()
			get_child(child_scenes.PAUSE_SCREEN).hide()
		elif GameState.game_started == true:
			get_child(child_scenes.PAUSE_SCREEN).show()
			get_tree().paused = true
			GameState.pause_game()
