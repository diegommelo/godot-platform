extends Node

const POSITIONS = [
  Vector2(101,200),
  Vector2(180,140),
  Vector2(310,205),
  Vector2(390,230),
  Vector2(420,50),
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

var _fruits: Array = ["apple","cherry","banana", "kiwi", "melon", "orange", "pineapple", "strawberry"]
var _fruits_full: Array = []
var _selected_fruits: Array = []

func _ready():
  get_fruits()
  load_fruits()
  
func get_fruit() -> String:
  if _fruits.is_empty():
    _fruits = _fruits_full.duplicate()
    _fruits.shuffle()
  var random_fruit = _fruits.pop_front()
  return random_fruit 

func get_fruits() -> void:
  randomize()
  _fruits_full = _fruits.duplicate()
  _fruits.shuffle()
  for i in 6:
    var fruit = get_fruit()
    _selected_fruits.append(fruit)

func load_fruits() -> void:
  for fruit in _selected_fruits:
    var obj = fruits_scenes.get(fruit).instantiate()
    var idx = _selected_fruits.find(fruit)
    obj.set_position(POSITIONS[idx])
    get_parent().add_child.call_deferred(obj)