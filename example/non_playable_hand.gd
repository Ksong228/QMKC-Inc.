extends CardCollection3D


func can_insert_card(_card, from_collection) -> bool:
	return false

func can_reorder_card(_card) -> bool:
	return false

func can_remove_card(_card) ->bool:
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
