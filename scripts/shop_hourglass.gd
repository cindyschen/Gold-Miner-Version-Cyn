extends VBoxContainer


@onready var hourglass_price: RichTextLabel = $HourglassPrice
@onready var item_button: TextureButton = $ItemButton

var price = randi_range(300,500)
var purchased = false
var description = "The hourglass grants you an extra 15 seconds on the next stage."

func _ready():
	GameManager.money_changed.connect(update)
	hourglass_price.text = "$" + str(price)
	update()
		
func update():
	if purchased:
		return
	if GameManager.score < price:
		item_button.disabled = true
		hourglass_price.add_theme_color_override("default_color", Color.RED)
	else:
		item_button.disabled = false
		hourglass_price.add_theme_color_override("default_color", Color.WHITE)

func _on_item_button_pressed() -> void:
	if purchased:
		return
	purchased = true
	GameManager.hourglass()
	GameManager.subtract_points(price)
	item_button.disabled = true
	hourglass_price.text = "SOLD"
	
