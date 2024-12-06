extends Node

signal player_connected(peer_id, player_info)
signal player_disconnected(peer_id)
signal server_disconnected
signal connection_failed
signal connection_successful
signal game_scene_changed(scene_path)

const PORT = 7000
const MAX_CONNECTIONS = 4

var players = {}
var player_info = {"name": "Name"}
var room_code = ""
var current_game_scene = ""

func _ready():
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.connection_failed.connect(_on_connection_failed)
	multiplayer.server_disconnected.connect(_on_server_disconnected)

func generate_room_code() -> String:
	var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	var code = ""
	for i in range(4):
		code += chars[randi() % chars.length()]
	return code

func create_game():
	var peer = ENetMultiplayerPeer.new()
	room_code = generate_room_code()
	var port = PORT + room_code.hash() % 100
	var error = peer.create_server(port, MAX_CONNECTIONS)
	if error:
		return error
	multiplayer.multiplayer_peer = peer
	players[1] = player_info
	player_connected.emit(1, player_info)
	return OK

func join_game(code: String):
	room_code = code.to_upper()
	var peer = ENetMultiplayerPeer.new()
	var port = PORT + room_code.hash() % 100
	var error = peer.create_client("127.0.0.1", port)
	if error:
		return error
	multiplayer.multiplayer_peer = peer
	return OK

func _on_player_connected(id):
	register_player.rpc_id(id, player_info)

func _on_player_disconnected(id):
	players.erase(id)
	player_disconnected.emit(id)

func _on_connected_to_server():
	var peer_id = multiplayer.get_unique_id()
	players[peer_id] = player_info
	player_connected.emit(peer_id, player_info)
	connection_successful.emit()

func _on_connection_failed():
	multiplayer.multiplayer_peer = null
	connection_failed.emit()

func _on_server_disconnected():
	multiplayer.multiplayer_peer = null
	players.clear()
	server_disconnected.emit()

func disconnect_game():
	if multiplayer.multiplayer_peer:
		multiplayer.multiplayer_peer.close()
		multiplayer.multiplayer_peer = null
	players.clear()

@rpc("any_peer", "reliable")
func register_player(info):
	var id = multiplayer.get_remote_sender_id()
	players[id] = info
	player_connected.emit(id, info)

@rpc("authority", "reliable", "call_local")
func change_game_scene(scene_path: String):
	current_game_scene = scene_path
	game_scene_changed.emit(scene_path)
	get_tree().change_scene_to_file(scene_path)
