extends VBoxContainer


@onready var dynamite_sprite: Sprite2D = $dynamiteSprite
@onready var dynamite_price: RichTextLabel = $dynamitePrice
@onready var shop_dynamite_button: TextureButton = $shopDynamiteButton

var price = randi_range(50,100)

func _ready():
	GameManager.money_changed.connect(update)
	dynamite_price.text = "$" + str(price)
	if GameManager.dynamite == GameManager.MAX_DYNAMITES:
		shop_dynamite_button.disabled = true
		dynamite_price.text = "MAXED OUT"
	elif GameManager.score < price:
		shop_dynamite_button.disabled = true
		
func update():
	if GameManager.score < price:
		shop_dynamite_button.disabled = true
	
		


func _on_shop_dynamite_button_pressed() -> void:
	GameManager.add_dynamite()
	GameManager.subtract_points(price)
	queue_free()
