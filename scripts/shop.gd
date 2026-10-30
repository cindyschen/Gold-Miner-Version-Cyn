extends Control

const DYNAMITE= preload("res://scenes/shop_items/shop_dynamite.tscn")
@onready var items_container: HBoxContainer = $PanelContainer/VBoxContainer/ItemsContainer
@onready var money_label: RichTextLabel = $PanelContainer/VBoxContainer/MoneyLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.money_changed.connect(updateMoney)
	money_label.text = "Money: $" + str(GameManager.score)
	var sell_dynamite = randi_range(0,1)
	if sell_dynamite == 1:
		var dynamite = DYNAMITE.instantiate()
		items_container.add_child(dynamite)
		
func updateMoney():
	money_label.text = "Money: $" + str(GameManager.score)

func _on_continue_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(GameManager.next_stage)
