extends Control

func _on_single_player_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_create_game_pressed() -> void:
	pass # Replace with function body.


func _on_join_game_pressed() -> void:
	pass # Replace with function body.


func _on_resume_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	pass # Replace with function body.
	get_tree().quit()
