extends Control

@export var code_line_edit: LineEdit
@export var player_name_edit: LineEdit
@export var status_label: Label

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main menu.tscn")

func _on_mizuno_pressed() -> void:
	get_tree().change_scene_to_file("res://example/mizunotable.tscn")
	
func _on_solitare_pressed() -> void:
	get_tree().change_scene_to_file("res://example_solitaire/scenes/solitaire.tscn")

func _on_sandbox_pressed() -> void:
	get_tree().change_scene_to_file("res://example/sandbox.tscn")

func _ready():
	multiplayer.connection_failed.connect(_on_connection_failed)
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	
func _on_host_button_pressed():
	if player_name_edit and player_name_edit.text:
		Network.player_info["name"] = player_name_edit.text
	Network.create_game()
	if status_label:
		status_label.text = "HOSTING - Code: " + Network.room_code
	
func _on_join_button_pressed():
	if player_name_edit and player_name_edit.text:
		Network.player_info["name"] = player_name_edit.text
	if code_line_edit and code_line_edit.text:
		Network.join_game(code_line_edit.text)
		if status_label:
			status_label.text = "CONNECTING..."
	
func _on_connection_failed():
	if status_label:
		status_label.text = "CONNECTION FAILED"
	
func _on_connected_to_server():
	if status_label:
		status_label.text = "CONNECTED!"

@rpc("authority", "reliable", "call_local")
func switch_game(game_scene: String):
	print("Switching scene to: " + game_scene)
	get_tree().change_scene_to_file(game_scene)

func _on_join_pressed() -> void:
	pass # Replace with function body.
