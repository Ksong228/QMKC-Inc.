extends CanvasLayer

@onready var panel: Panel = $Panel
@onready var label: Label = $Panel/Label
@onready var PlayAgainButton: Button = $Panel/PlayAgainButton
@onready var ExitToLobbyButton: Button = $Panel/ExitToLobbyButton

func _ready() -> void:
	hide_win_screen()

func show_win_screen(winner: String):
	var wintext = "Player %s Wins!" % winner
	label.text = wintext
	panel.visible = true

func hide_win_screen():
	panel.visible = false

func _on_play_again_button_button_down() -> void:
	hide_win_screen()
	get_tree().reload_current_scene()

func _on_exit_to_lobby_button_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/lobby menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
