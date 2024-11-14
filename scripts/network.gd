extends Node

const MAX_USERS : int = 4

@onready var network = $"Local network"
@onready var ip_input = $VBoxContainer/IP
@onready var port_input = $VBoxContainer/Port

var local_username : String

func _ready():
	pass
	
func start_host ():
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(int(port_input.text), MAX_USERS)
	multiplayer.multiplayer_peer = peer
	
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	
	
func join_game ():
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(ip_input.text, int(port_input.text))
	multiplayer.multiplayer_peer = peer
	
	multiplayer.connected_to_server.connect(_connected_to_server)
	multiplayer.connection_failed.connect(_connection_failed)
	multiplayer.server_disconnected.connect(_server_disconnected)
	
func _on_player_connected (id : int):
	print("Player %s joined the game." % id)
	
func _on_player_disconnected (id : int):
	print("Player %s left the game." % id)


func _connected_to_server ():
	print("Connected to server.")
	network.visible = false
	
func _connection_failed ():
	print("Connection failed!")
	
func _server_disconnected ():
	print("Server disconnected.")
	
func _on_user_text_changed(new_text: String) -> void:
	local_username = new_text
