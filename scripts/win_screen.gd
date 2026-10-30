extends Control

@export var next_stage: String = "res://scenes/stage_2.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	
func _on_continue_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(next_stage)

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
