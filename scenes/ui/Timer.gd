extends Label

func _process(delta):
	text = str(GameState.game_time).pad_decimals(1)
