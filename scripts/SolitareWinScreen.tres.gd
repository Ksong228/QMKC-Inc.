extends Node2D

func _on_return_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/lobby menu.tscn")
	

func _on_again_button_down() -> void:
	get_tree().change_scene_to_file("res://example_solitaire/scenes/solitaire.tscn")
