extends Control

@export var player_name_edit: LineEdit
@export var status_label: Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _ready():
	multiplayer.connection_failed.connect(_on_connection_failed)
	multiplayer.connected_to_server.connect(_on_connected_to_server)

func _on_mizuno_button_down() -> void:
	if multiplayer.is_server():
		var scene_path = "res://example/mizunotable.tscn"
		print("Switching to Mizuno: " + scene_path)
		Network.change_game_scene.rpc(scene_path)
	else:
		rpc("change_game_scene", "res://example/mizunotable.tscn")

func _on_sandbox_button_down() -> void:
	if multiplayer.is_server():
		var scene_path = "res://example/sandbox.tscn"
		print("Switching to Sandbox: " + scene_path)
		Network.change_game_scene.rpc(scene_path)
	else:
		rpc("change_game_scene", "res://example/sandbox.tscn")

func _on_back_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/main menu.tscn")
	
func _on_host_button_pressed():
	if player_name_edit and player_name_edit.text:
		Network.player_info["name"] = player_name_edit.text
	Network.create_game()
	if status_label:
		status_label.text = "HOSTING - Code: " + Network.room_code
	
func _on_connection_failed():
	if status_label:
		status_label.text = "CONNECTION FAILED"
	
func _on_connected_to_server():
	if status_label:
		status_label.text = "CONNECTED!"

@rpc("authority", "reliable", "call_local")
func change_game_scene(game_scene: String):
	print("Switching scene to: " + game_scene)
	get_tree().change_scene_to_file(game_scene)
