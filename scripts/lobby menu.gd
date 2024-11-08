extends Control

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main menu.tscn")

func _on_solitaire_pressed() -> void:
	get_tree().change_scene_to_file("res://example_solitaire/scenes/solitaire.tscn")
