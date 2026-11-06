extends VBoxContainer


@onready var dynamite_price: RichTextLabel = $dynamitePrice
@onready var item_button: TextureButton = $ItemButton

var price = randi_range(50,100)
var purchased = false
var description = "This explosive can be used to destroy the object you are retracting. One time use."

func _ready():
	GameManager.money_changed.connect(update)
	dynamite_price.text = "$" + str(price)
	update()
		
func update():
	if purchased:
		return
	if GameManager.dynamite == GameManager.MAX_DYNAMITES:
		item_button.disabled = true
		dynamite_price.text = "MAXED"
	elif GameManager.score < price:
		item_button.disabled = true
		dynamite_price.add_theme_color_override("default_color", Color.RED)
	else:
		item_button.disabled = false
		dynamite_price.add_theme_color_override("default_color", Color.WHITE)
	
func _on_item_button_pressed() -> void:
	if purchased:
		return
	purchased = true
	GameManager.add_dynamite()
	GameManager.subtract_points(price)
	item_button.disabled = true
	dynamite_price.text = "SOLD"
