class_name LevelMachine
extends Node

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
