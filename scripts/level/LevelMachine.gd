extends Node

@onready var character = $NinjaFrog
@onready var start_timer = $StartTimer

@export var POSITIONS = [
	Vector2(0,0),
	Vector2(0,0),
	Vector2(0,0),
	Vector2(0,0),
	Vector2(0,0),
	Vector2(0,0),
]
#const POSITIONS = [
  #Vector2(62.207,143.368),
  #Vector2(138.911,98.503),
  #Vector2(267.341,160.097),
  #Vector2(351.112,185.01),
  #Vector2(382.767,9.891),
  #Vector2(47.388,-4.491),
#]
var fruits_scenes: Dictionary = {
  "apple": "res://scenes/items/fruits/apple.tscn",
  "cherry": "res://scenes/items/fruits/cherry.tscn",
  "banana": "res://scenes/items/fruits/banana.tscn",
  "kiwi": "res://scenes/items/fruits/kiwi.tscn",
  "melon": "res://scenes/items/fruits/melon.tscn",
  "orange": "res://scenes/items/fruits/orange.tscn",
  "pineapple": "res://scenes/items/fruits/pineapple.tscn",
  "strawberry": "res://scenes/items/fruits/strawberry.tscn",
}
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
var response: Array = []
var collected: Array = []
var answers: Array = []
#var answers_time: Array = []
#var time: float = 0.0
#var time_stopped: bool = false
#var game_started: bool = false
var ordered_fruits: Array = []
var selected_fruits: Array = []
var shuffled_fruits: Array = []

func _ready():
	selected_fruits = get_fruits()
	response = get_ordered_fruits(selected_fruits)
	load_fruits(selected_fruits)
	
func _process(delta: float) -> void:
	if start_timer.time_left == 0 and GameState.game_time_stopped == false:
		start_game()
		
	if GameState.game_started:
		if not GameState.game_time_stopped:
			GameState.game_time += delta
	
func _on_fruit_collected(fruit):
	collected.append(fruit.to_lower())
	#answers_time.append(time)
	if collected.size() == 6:
		check_if_all_colected()
		stop_game()

func load_fruits(fruits_to_load: Array) -> void:
	for fruit in fruits_to_load:
		var fruit_file = load(fruits_scenes.get(fruit))
		var scene = fruit_file.instantiate()
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

func start_game():
	character.can_move = true
	GameState.game_started = true
	
func stop_game():
	character.can_move = false
	GameState.game_time_stopped = true

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
