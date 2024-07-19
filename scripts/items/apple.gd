extends Area2D

func _on_body_entered(body):
	queue_free()
	var apples = get_tree().get_nodes_in_group("Apples")
	if apples.size() == 1:
		Events.level_completed.emit()
