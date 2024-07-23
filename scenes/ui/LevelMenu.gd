extends MarginContainer

var num_grids = 1
var current_grid = 1
var grid_width = 354

@onready var grid_box = $VBoxContainer/HBoxContainer/ClipControl/GridBox
@export var levels: LevelsData

func _ready():
	num_grids = grid_box.get_child_count()
	var children = 0
	for grid in grid_box.get_children():
		for box in grid.get_children():
			if children <= 5:
				children = box.get_index() + 1
				box.level_num = children
			elif children >= 6:
				children += 1
				box.level_num = children
			box.locked = levels.levels.get("level_" + str(children)).locked

func _on_back_button_pressed():
	if current_grid > 1:
		current_grid -= 1
		var tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		tween.tween_property(grid_box, "position:x", grid_box.position.x + grid_width, 0.5)

func _on_next_button_pressed():
	if current_grid < num_grids:
		current_grid += 1
		var tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		tween.tween_property(grid_box, "position:x", grid_box.position.x - grid_width, 0.5)
