extends Control


func _on_button_pressed() -> void:
	GameManager.next_stage()
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()
