extends Control

@onready var joinPanel: Panel = $JoinPanel

func _ready() -> void:
	hide_join_panel()

func _on_single_player_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/singleplayer.tscn")
	
func _on_host_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/multiplayerLobby.tscn")
	
func _on_join_game_pressed() -> void:
	show_join_panel()
	
func _on_exit_pressed() -> void:
	get_tree().exit

#join panel stuff
func show_join_panel():
	joinPanel.visible = true
	
func hide_join_panel():
	joinPanel.visible = false

func _on_close_button_button_down() -> void:
	hide_join_panel()
	
func _on_join_button_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/multiplayerLobby.tscn")
	#replace the above line with checking the code decrypting the code into the hosts ip, checking if there is a host with that ip and joining that lobby
