extends Node

@onready var level_machine : LevelMachine = $LevelMachine

const POSITIONS = [
  Vector2(62.207,143.368),
  Vector2(138.911,98.503),
  Vector2(267.341,160.097),
  Vector2(351.112,185.01),
  Vector2(376.767,9.891),
  Vector2(38.388,-4.491),
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
var response: Array = []
var collected: Array = []
var answers: Array = []
var answers_time: Array = []
var time: float = 0.0

func _ready():
	var selected_fruits: Array = []
	selected_fruits = level_machine.get_fruits()
	response = level_machine.get_ordered_fruits(selected_fruits)
	load_fruits(selected_fruits)
	
func _process(delta: float) -> void:
	time+=delta
	
func load_fruits(selected_fruits: Array) -> void:
	for fruit in selected_fruits:
		var scene = fruits_scenes.get(fruit).instantiate()
		scene.connect("fruit_collected", _on_fruit_collected)
		var idx = selected_fruits.find(fruit)
		scene.set_position(POSITIONS[idx])
		add_child.call_deferred(scene)
	
func _on_fruit_collected(fruit):
	collected.append(fruit.to_lower())
	answers_time.append(time)
	
	if collected.size() == 6:
		check_if_all_colected()

func check_if_all_colected():
	for fruit in collected:
		var idx = response.find(fruit)
		if collected[idx] == response[idx]:
			answers.append(true)
		else:
			answers.append(false)
	print(", ".join(answers))
	print(", ".join(answers_time))
