extends Control

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main menu.tscn")

func _on_mizuno_pressed() -> void:
	get_tree().change_scene_to_file("res://example/mizunotable.tscn")
	
func _on_solitare_pressed() -> void:
	get_tree().change_scene_to_file("res://example_solitaire/scenes/solitaire.tscn")

func _on_sandbox_pressed() -> void:
	get_tree().change_scene_to_file("res://example/sandbox.tscn")