extends VBoxContainer


@onready var shop_elixir_button: TextureButton = $shopElixirButton
@onready var elixir_price: RichTextLabel = $ElixirPrice


var price = randi_range(300,500)
var purchased = false

func _ready():
	GameManager.money_changed.connect(update)
	elixir_price.text = "$" + str(price)
	if GameManager.score < price:
		shop_elixir_button.disabled = true
		elixir_price.add_theme_color_override("default_color", Color.RED)
		
func update():
	if purchased:
		return
	if GameManager.score < price:
		shop_elixir_button.disabled = true
		elixir_price.add_theme_color_override("default_color", Color.RED)
	else:
		shop_elixir_button.disabled = false
		elixir_price.add_theme_color_override("default_color", Color.WHITE)

func _on_shop_elixir_button_pressed() -> void:
	if purchased:
		return
	purchased = true
	GameManager.elixir()
	GameManager.subtract_points(price)
	shop_elixir_button.disabled = true
	elixir_price.text = "SOLD"
	
