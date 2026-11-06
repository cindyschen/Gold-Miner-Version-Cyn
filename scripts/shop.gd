extends Control

#chance of item, stage it begins appearing
const SHOP_ITEMS = [
	{"scene": preload("res://scenes/shop_items/shop_dynamite.tscn"), "chance": 80, "stage": 0},
	{"scene": preload("res://scenes/shop_items/shop_energy_drink.tscn"), "chance": 30, "stage": 0},
	{"scene": preload("res://scenes/shop_items/shop_hourglass.tscn"), "chance": 30, "stage": 0},
	{"scene": preload("res://scenes/shop_items/shop_elixir.tscn"), "chance": 50, "stage": 3},
	{"scene": preload("res://scenes/shop_items/shop_hammer.tscn"), "chance": 60, "stage": 0}
]
@onready var items_container: HBoxContainer = $PanelContainer/VBoxContainer/ItemsContainer
@onready var money_label: RichTextLabel = $PanelContainer/VBoxContainer/MoneyLabel
@onready var description_container: PanelContainer = $PanelContainer/VBoxContainer/HBoxContainer/DescriptionContainer
@onready var description: RichTextLabel = $PanelContainer/VBoxContainer/HBoxContainer/DescriptionContainer/Description

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	description_container.hide()
	GameManager.money_changed.connect(updateMoney)
	money_label.text = "Money: $" + str(GameManager.score)
	for item in SHOP_ITEMS:
		var random_number = randi_range(0, 100)
		if random_number <= item["chance"] and GameManager.stage >= item["stage"]:
			var new_item = item["scene"].instantiate()
			items_container.add_child(new_item)
			var button = new_item.get_node("ItemButton")
			button.mouse_entered.connect(_on_item_hovered.bind(new_item))
			button.mouse_exited.connect(_on_item_unhovered)
		
func updateMoney():
	money_label.text = "Money: $" + str(GameManager.score)

func _on_continue_button_pressed() -> void:
	get_tree().paused = false
	GameManager.next_stage()
	
func _on_item_hovered(item):
	description_container.show()
	description.text = item.description
	
func _on_item_unhovered():
	description_container.hide()
