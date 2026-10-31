extends VBoxContainer


@onready var dynamite_price: RichTextLabel = $dynamitePrice
@onready var shop_dynamite_button: TextureButton = $shopDynamiteButton

var price = randi_range(50,100)
var purchased = false

func _ready():
	GameManager.money_changed.connect(update)
	dynamite_price.text = "$" + str(price)
	update()
		
func update():
	if purchased:
		return
	if GameManager.dynamite == GameManager.MAX_DYNAMITES:
		shop_dynamite_button.disabled = true
		dynamite_price.text = "MAXED OUT"
	elif GameManager.score < price:
		shop_dynamite_button.disabled = true
		dynamite_price.add_theme_color_override("default_color", Color.RED)
	else:
		shop_dynamite_button.disabled = false
		dynamite_price.add_theme_color_override("default_color", Color.WHITE)
	
func _on_shop_dynamite_button_pressed() -> void:
	if purchased:
		return
	purchased = true
	GameManager.add_dynamite()
	GameManager.subtract_points(price)
	shop_dynamite_button.disabled = true
	dynamite_price.text = "SOLD"
