extends MarginContainer

func _init():
	EventBus.connect("fruit_picked", _on_fruit_picked)
	
func _on_fruit_picked(fruits_collected: Array) -> void:
	print('pegou')
	#for fruit in fruits_collected:
		#var slot = fruit_slot.instantiate()
		#var child = slot.get_node(fruit)
		#child.visible = true
		#get_node("VBoxContainer/GridContainer").add_child(slot)
	
