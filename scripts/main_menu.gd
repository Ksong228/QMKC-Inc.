extends Control

@export var joinPanel: Panel
@export var room_code_input: LineEdit
@export var join_status_label: Label

func _ready() -> void:
	hide_join_panel()
	# Connect to network signals
	Network.connection_failed.connect(_on_connection_failed)
	Network.connection_successful.connect(_on_connection_successful)

func _on_single_player_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/singleplayer.tscn")

func _on_host_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/multiplayerLobby.tscn")

func _on_join_game_pressed() -> void:
	show_join_panel()

func _on_exit_pressed() -> void:
	get_tree().exit

func show_join_panel():
	joinPanel.visible = true

func hide_join_panel():
	joinPanel.visible = false

func _on_close_button_button_down() -> void:
	hide_join_panel()

func _on_join_button_button_down() -> void:
	if room_code_input and room_code_input.text:
		if join_status_label:
			join_status_label.text = "CONNECTING..."
		
		var result = Network.join_game(room_code_input.text)
	else:
		# Show an error if no room code is entered
		if join_status_label:
			join_status_label.text = "ENTER LOBBY CODE!"

func _on_connection_failed():
	if join_status_label:
		join_status_label.text = "CONNECTION FAILED!"

func _on_connection_successful():
	if join_status_label:
		join_status_label.text = "CONNECTED!"
