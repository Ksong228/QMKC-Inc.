extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MenuButton.get_popup().add_item("Resume")
	$MenuButton.get_popup().add_item("Restart")
	$MenuButton.get_popup().add_item("Exit to Lobby")
	$MenuButton.get_popup().connect("id_pressed", _on_item_pressed)

func _on_item_pressed(id):
	var item_name = $MenuButton.get_popup().get_item_text(id)
	match item_name:
		"Resume":
			pass
		"Restart":
			get_tree().reload_current_scene()
		"Exit to Lobby":
			get_tree().change_scene_to_file("res://scenes/lobby menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
