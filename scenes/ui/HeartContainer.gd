extends GridContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.connect("character_take_damage", _on_character_take_damage)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_character_take_damage() -> void:
	var hearts = get_children()
	hearts[GameState.player_hearts].get_child(0).frame = 1
