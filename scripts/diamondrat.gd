extends Area2D

@export var retract_speed: float = 200.0
@export var points: int = 5 + 500 * GameManager.diamond_multiplier
@export var distance: int = 200
@export var direction: int = 1
@onready var wait_timer: Timer = $waitTimer
@onready var diamondrat: AnimatedSprite2D = $diamondratSprite

var speed = 150
var start_x = 0
var waiting = false

func _ready():
	start_x = position.x
	if direction == 1:
		scale.x = -1
	else:
		scale.x = 1
		
func _process(delta):
	if get_parent().name == "claw" or waiting:
		diamondrat.pause()
		diamondrat.frame = 0
		return
	position.x += speed*delta*direction
	if position.x > start_x + distance:
		waiting = true
		wait_timer.start()
		await wait_timer.timeout
		if get_parent().name == "claw":
			return
		scale.x = 1
		direction = -1
		waiting = false
		diamondrat.play()
	elif position.x < start_x - distance:
		waiting = true
		wait_timer.start()
		await wait_timer.timeout
		if get_parent().name == "claw":
			return
		scale.x = -1
		direction = 1
		waiting = false
		diamondrat.play()
