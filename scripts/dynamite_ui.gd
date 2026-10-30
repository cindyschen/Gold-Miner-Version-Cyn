extends Control

@onready var dynamite_container: HBoxContainer = $DynamiteContainer

const DYNAMITE_SCENE = preload("res://scenes/dynamite_icon.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.dynamite_changed.connect(update)
	for i in range(GameManager.dynamite):
		var dynamite = DYNAMITE_SCENE.instantiate()
		dynamite_container.add_child(dynamite)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	for child in dynamite_container.get_children():
		child.queue_free()
	
	for i in range(GameManager.dynamite):
		var dynamite = DYNAMITE_SCENE.instantiate()
		dynamite_container.add_child(dynamite)
