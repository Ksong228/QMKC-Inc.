extends CanvasLayer

@onready var menubox: VBoxContainer = $MenuBox

func _ready():
	menubox.hide()
	pass
	
func _on_menu_button_button_down() -> void:
	if menubox.visible:
		menubox.hide()
		print("menubox hidden")
	else:
		menubox.show()	
		print("Menu box showing")

func _on_resume_button_pressed() -> void:
	menubox.hide()

func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_exit_to_lobby_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/lobby menu.tscn")
