extends Node

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
var ordered_fruits: Array = []
var selected_fruits: Array = []
var shuffled_fruits: Array = []
var fruits_data: Array = [
  "apple",
  "cherry",
  "banana",
  "kiwi",
  "melon",
  "orange",
  "pineapple",
  "strawberry"
]

func _ready():
	# var selected_fruits: Array = []
	selected_fruits = get_fruits()
	response = get_ordered_fruits(selected_fruits)
	load_fruits(selected_fruits)
	
func _process(delta: float) -> void:
	time += delta
	
func _on_fruit_collected(fruit):
	collected.append(fruit.to_lower())
	answers_time.append(time)
	if collected.size() == 6:
		check_if_all_colected()

func load_fruits(fruits_to_load: Array) -> void:
	for fruit in fruits_to_load:
		var scene = fruits_scenes.get(fruit).instantiate()
		scene.connect("fruit_collected", _on_fruit_collected)
		var idx = fruits_to_load.find(fruit)
		scene.set_position(POSITIONS[idx])
		add_child.call_deferred(scene)

func check_if_all_colected() -> void:
	for fruit in collected:
		var idx = response.find(fruit)
		if collected[idx] == response[idx]:
			answers.append(true)
		else:
			answers.append(false)
	print(", ".join(answers))
	print(", ".join(answers_time))

func get_fruit() -> String:
	if shuffled_fruits.is_empty():
		shuffled_fruits = fruits_data.duplicate()
		shuffled_fruits.shuffle()
	var random_fruit = shuffled_fruits.pop_front()
	return random_fruit
	
func get_fruits() -> Array:
	shuffled_fruits = fruits_data.duplicate()
	shuffled_fruits.shuffle()
	for i in 6:
		var fruit = get_fruit()
		selected_fruits.append(fruit)
	return selected_fruits

func get_ordered_fruits(fruits_to_order: Array) -> Array:
		ordered_fruits = fruits_to_order.duplicate()
		ordered_fruits.shuffle()
		return ordered_fruits
