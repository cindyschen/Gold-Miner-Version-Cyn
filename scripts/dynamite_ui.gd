extends Control

@onready var dynamite_container: HBoxContainer = $DynamiteContainer

const DYNAMITE_SCENE = preload("res://scenes/dynamite.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(GameManager.dynamite):
		var dynamite = DYNAMITE_SCENE.instantiate()
		dynamite_container.add_child(dynamite)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
