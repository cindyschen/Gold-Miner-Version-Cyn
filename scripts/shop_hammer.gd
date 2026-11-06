extends VBoxContainer

@onready var hammer_price: RichTextLabel = $HammerPrice
@onready var item_button: TextureButton = $ItemButton

var price = randi_range(50,100)
var purchased = false
var description = "This tool finds hidden minerals in rocks, doubling the price of rocks for the next stage."

func _ready():
	GameManager.money_changed.connect(update)
	hammer_price.text = "$" + str(price)
	update()
		
func update():
	if purchased:
		return
	if GameManager.score < price:
		item_button.disabled = true
		hammer_price.add_theme_color_override("default_color", Color.RED)
	else:
		item_button.disabled = false
		hammer_price.add_theme_color_override("default_color", Color.WHITE)

func _on_item_button_pressed() -> void:
	if purchased:
		return
	purchased = true
	GameManager.hammer()
	GameManager.subtract_points(price)
	item_button.disabled = true
	hammer_price.text = "SOLD"
	
