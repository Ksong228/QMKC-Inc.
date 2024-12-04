extends CardCollection3D


func can_insert_card(_card, from_collection) -> bool:
	return from_collection == self

func can_reorder_card(_card) -> bool:
	return true

func can_remove_card(_card) ->bool:
	return true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
