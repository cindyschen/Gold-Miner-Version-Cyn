extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/stage_1.tscn")
	
func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
