class_name LevelMachine
extends Node

var fruits_full: Array = []
var selected_fruits: Array = []
var fruits: Array = [
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
  var random_fruit: String
  if fruits.is_empty():
    fruits = fruits_full.duplicate()
    fruits.shuffle()
  random_fruit = fruits.pop_front()
  return random_fruit

func get_fruits() -> Array:
  randomize()
  fruits_full = fruits.duplicate()
  fruits.shuffle()
  for i in 6:
    var fruit = get_fruit()
    selected_fruits.append(fruit)
  return selected_fruits

