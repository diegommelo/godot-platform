class_name Item
extends Node

signal fruit_collected(fruit)

func _ready():
	pass
	#add_to_group("items")

func _on_body_entered(_body):
	fruit_collected.emit(name)
	queue_free()
