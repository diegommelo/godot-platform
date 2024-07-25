extends Label

func _process(_delta):
	text = str(GameState.game_time).pad_decimals(1)
