extends VBoxContainer


@onready var shop_hammer_button: TextureButton = $shopHammerButton
@onready var hammer_price: RichTextLabel = $HammerPrice


var price = randi_range(50,100)
var purchased = false

func _ready():
	GameManager.money_changed.connect(update)
	hammer_price.text = "$" + str(price)
	if GameManager.score < price:
		shop_hammer_button.disabled = true
		hammer_price.add_theme_color_override("default_color", Color.RED)
		
func update():
	if purchased:
		return
	if GameManager.score < price:
		shop_hammer_button.disabled = true
		hammer_price.add_theme_color_override("default_color", Color.RED)
	else:
		shop_hammer_button.disabled = false
		hammer_price.add_theme_color_override("default_color", Color.WHITE)

func _on_shop_hammer_button_pressed() -> void:
	if purchased:
		return
	purchased = true
	GameManager.hammer()
	GameManager.subtract_points(price)
	shop_hammer_button.disabled = true
	hammer_price.text = "SOLD"
	
