extends Control

var paused = false

func _ready() -> void:
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("process run")
	if Input.is_action_just_pressed("pause"):
		print("hi")
		if paused == false:
			show()
			get_tree().paused = true
			paused = true
		else:
			hide()
			get_tree().paused = false
			paused = false

func _on_resume_button_pressed() -> void:
	hide()
	get_tree().paused = false
	paused = false
	
func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
