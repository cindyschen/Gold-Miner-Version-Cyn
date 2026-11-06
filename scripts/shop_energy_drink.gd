extends VBoxContainer


@onready var energy_drink_price: RichTextLabel = $EnergyDrinkPrice
@onready var item_button: TextureButton = $ItemButton

var price = randi_range(300,500)
var purchased = false
var description = "Drinking this energy drink makes you twice as strong for the next stage."

func _ready():
	GameManager.money_changed.connect(update)
	energy_drink_price.text = "$" + str(price)
	update()
		
func update():
	if purchased:
		return
	if GameManager.score < price:
		item_button.disabled = true
		energy_drink_price.add_theme_color_override("default_color", Color.RED)
	else:
		item_button.disabled = false
		energy_drink_price.add_theme_color_override("default_color", Color.WHITE)

func _on_item_button_pressed() -> void:
	if purchased:
		return
	purchased = true
	GameManager.energy_drink()
	GameManager.subtract_points(price)
	item_button.disabled = true
	energy_drink_price.text = "SOLD"
	
