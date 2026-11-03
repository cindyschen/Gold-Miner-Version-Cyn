extends Area2D

@export var retract_speed: float = 200.0
@export var points: int = 5
@export var distance: int = 200
@export var direction: int = 1
@onready var wait_timer: Timer = $waitTimer

var speed = 150
var start_x = 0
var waiting = false

func _ready():
	start_x = position.x
		
func _process(delta):
	if get_parent().name == "claw" or waiting:
		return
	position.x += speed*delta*direction
	if position.x > start_x + distance:
		waiting = true
		wait_timer.start()
		await wait_timer.timeout
		direction = -1
		waiting = false
	elif position.x < start_x - distance:
		waiting = true
		wait_timer.start()
		await wait_timer.timeout
		direction = 1
		waiting = false
