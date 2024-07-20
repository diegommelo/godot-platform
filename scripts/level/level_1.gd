extends Node

@onready var level_machine : LevelMachine = $LevelMachine

const POSITIONS = [
  Vector2(101,190),
  Vector2(180,140),
  Vector2(310,205),
  Vector2(390,230),
  Vector2(415,50),
  Vector2(78,40),
]

var fruits_scenes: Dictionary = {
  "apple": preload("res://scenes/items/apple.tscn"),
  "cherry": preload("res://scenes/items/cherry.tscn"),
  "banana": preload("res://scenes/items/banana.tscn"),
  "kiwi": preload("res://scenes/items/kiwi.tscn"),
  "melon": preload("res://scenes/items/melon.tscn"),
  "orange": preload("res://scenes/items/orange.tscn"),
  "pineapple": preload("res://scenes/items/pineapple.tscn"),
  "strawberry": preload("res://scenes/items/strawberry.tscn"),
}

func _ready():
	var selected_fruits: Array = []
	var response: Array = []
	selected_fruits = level_machine.get_fruits()
	response = level_machine.get_ordered_fruits(selected_fruits)
	load_fruits(selected_fruits)

func load_fruits(selected_fruits: Array) -> void:
	for fruit in selected_fruits:
		var obj = fruits_scenes.get(fruit).instantiate()
		var idx = selected_fruits.find(fruit)
		obj.set_position(POSITIONS[idx])
		get_parent().add_child.call_deferred(obj)
