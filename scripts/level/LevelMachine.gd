extends Node

var character_scene = preload("res://scenes/chars/ninja_frog.tscn")
@onready var start_timer = $StartTimer
@onready var character
@export var POSITIONS = [
	Vector2(0,0),
	Vector2(0,0),
	Vector2(0,0),
	Vector2(0,0),
	Vector2(0,0),
	Vector2(0,0),
]
@export var PLAYER_INITIAL_POSITION = Vector2(0,0)
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
var ordered_fruits: Array = []
var selected_fruits: Array = []
var shuffled_fruits: Array = []

func _init():
	load_fruits()
	
func _ready():
	GameState.set_player_initial_position(PLAYER_INITIAL_POSITION)
	EventBus.connect("start_game", _on_start_game)

func _process(delta: float) -> void:
	if GameState.game_started:
		if not GameState.game_time_stopped:
			GameState.game_time += delta

func get_random_fruit() -> String:
	if shuffled_fruits.is_empty():
		shuffled_fruits = fruits_data.duplicate()
		shuffled_fruits.shuffle()
	var random_fruit = shuffled_fruits.pop_front()
	return random_fruit
	
func get_fruits() -> Array:
	shuffled_fruits = fruits_data.duplicate()
	shuffled_fruits.shuffle()
	for i in 6:
		var fruit = get_random_fruit()
		selected_fruits.append(fruit)
	return selected_fruits

func get_ordered_fruits(fruits_to_order: Array) -> Array:
		ordered_fruits = fruits_to_order.duplicate()
		ordered_fruits.shuffle()
		return ordered_fruits
		
func load_fruits_in_scene(fruits_to_load: Array) -> void:
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
	
func load_fruits() -> void:
	selected_fruits = get_fruits()
	response = get_ordered_fruits(selected_fruits)
	#GameState.set_current_response(response)
	EventBus.fruits_picked.emit(response)

func load_character() -> void:
	character = character_scene.instantiate()
	character.set_position(PLAYER_INITIAL_POSITION)
	add_child(character)

func _on_start_game():
	load_fruits_in_scene(selected_fruits)
	load_character()
	GameState.start_game()
	character.unstop()

func _on_fruit_collected(fruit):
	collected.append(fruit.to_lower())
	#answers_time.append(time)
	if collected.size() == 6:
		check_if_all_colected()
		GameState.stop_game()
		character.stop()
