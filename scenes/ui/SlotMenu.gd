extends MarginContainer


var fruit_slot = preload("res://scenes/ui/FruitSlot.tscn")
#["apple", "banana", "cherry", "pineapple", "orange", "kiwi"]
func _ready():
	for fruit in GameState.get_current_response():
		#var texture = load("res//sprites/items/"+fruit.capitalize()+".png")
		var slot = fruit_slot.instantiate()
		#var path = "res://sprites/items/"+fruit.capitalize()+".png"
		var child = slot.get_node(fruit)
		child.visible = true
		#sprite.texture = load(path)
		#sprite.hframes = 17
		#sprite.vframes = 1
		#sprite.centered = true
		get_node("VBoxContainer/GridContainer").add_child(slot)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
