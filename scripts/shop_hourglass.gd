extends VBoxContainer


@onready var shop_hourglass_button: TextureButton = $shopHourglassButton
@onready var hourglass_price: RichTextLabel = $HourglassPrice


var price = randi_range(300,500)
var purchased = false

func _ready():
	GameManager.money_changed.connect(update)
	hourglass_price.text = "$" + str(price)
	if GameManager.score < price:
		shop_hourglass_button.disabled = true
		hourglass_price.add_theme_color_override("default_color", Color.RED)
		
func update():
	if purchased:
		return
	if GameManager.score < price:
		shop_hourglass_button.disabled = true
		hourglass_price.add_theme_color_override("default_color", Color.RED)
	else:
		shop_hourglass_button.disabled = false
		hourglass_price.add_theme_color_override("default_color", Color.WHITE)

func _on_shop_hourglass_button_pressed() -> void:
	if purchased:
		return
	purchased = true
	GameManager.hourglass()
	GameManager.subtract_points(price)
	shop_hourglass_button.disabled = true
	hourglass_price.text = "SOLD"
	
