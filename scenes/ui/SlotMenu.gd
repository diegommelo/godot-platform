extends MarginContainer

var fruit_slot = preload("res://scenes/ui/FruitSlot.tscn")

func _init():
	EventBus.connect("fruits_picked", _on_fruits_picked)

func _on_button_pressed():
	EventBus.start_game.emit()
	queue_free()

func _on_fruits_picked(fruits: Array) -> void:
	for fruit in fruits:
		var slot = fruit_slot.instantiate()
		var child = slot.get_node(fruit)
		child.visible = true
		get_node("VBoxContainer/GridContainer").add_child(slot)
