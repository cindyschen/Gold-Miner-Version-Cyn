extends VBoxContainer

@onready var item_button: TextureButton = $ItemButton
@onready var elixir_price: RichTextLabel = $ElixirPrice

var price = randi_range(300,500)
var purchased = false
var description = "This mysterious substance doubles the value of diamonds for the next stage."

func _ready():
	GameManager.money_changed.connect(update)
	elixir_price.text = "$" + str(price)
	update()

func update():
	if purchased:
		return
	if GameManager.score < price:
		item_button.disabled = true
		elixir_price.add_theme_color_override("default_color", Color.RED)
	else:
		item_button.disabled = false
		elixir_price.add_theme_color_override("default_color", Color.WHITE)

func _on_item_button_pressed() -> void:
	if purchased:
		return
	purchased = true
	GameManager.elixir()
	GameManager.subtract_points(price)
	item_button.disabled = true
	elixir_price.text = "SOLD"
	
