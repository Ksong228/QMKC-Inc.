extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_mizuno_button_down() -> void:
	get_tree().change_scene_to_file("res://example/mizunotable.tscn")
	
func _on_solitare_button_down() -> void:
	get_tree().change_scene_to_file("res://example_solitaire/scenes/solitaire.tscn")

func _on_sandbox_button_down() -> void:
	get_tree().change_scene_to_file("res://example/sandbox.tscn")

func _on_back_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/main menu.tscn")
