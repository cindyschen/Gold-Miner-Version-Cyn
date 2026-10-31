extends VBoxContainer


@onready var shop_energy_drink_button: TextureButton = $shopEnergyDrinkButton
@onready var energy_drink_price: RichTextLabel = $EnergyDrinkPrice


var price = randi_range(300,500)
var purchased = false

func _ready():
	GameManager.money_changed.connect(update)
	energy_drink_price.text = "$" + str(price)
	if GameManager.score < price:
		shop_energy_drink_button.disabled = true
		energy_drink_price.add_theme_color_override("default_color", Color.RED)
		
func update():
	if purchased:
		return
	if GameManager.score < price:
		shop_energy_drink_button.disabled = true
		energy_drink_price.add_theme_color_override("default_color", Color.RED)
	else:
		shop_energy_drink_button.disabled = false
		energy_drink_price.add_theme_color_override("default_color", Color.WHITE)

func _on_shop_energy_drink_button_pressed() -> void:
	if purchased:
		return
	purchased = true
	GameManager.energy_drink()
	GameManager.subtract_points(price)
	shop_energy_drink_button.disabled = true
	energy_drink_price.text = "SOLD"
	
