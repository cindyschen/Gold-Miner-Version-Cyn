extends Node2D

const SWING_ANGLE= 80.0
const SWING_SPEED= 2.0
const DROP_SPEED = 500
const RETRACT_SPEED = 600
const PADDING = 100

var direction = Vector2.DOWN
var dropping = false
var retracting = false
var object_retracting = false
var swing_time = 0
var start_position: Vector2
var object_retract_speed = 600
var object: Area2D

@onready var line: Line2D = $"../Line2D"
@onready var ray_cast: RayCast2D = $RayCast2D
@onready var pickup_point: Marker2D = $"../Marker2D"

func _ready() -> void:
	start_position = position

func _process(delta: float) -> void:
	var screen_size = get_viewport_rect().size
	line.clear_points()
	line.add_point(Vector2.ZERO)
	line.add_point(position)
	if not dropping and not retracting and not object_retracting:
		swing_time += delta
		rotation = deg_to_rad(SWING_ANGLE) * sin(swing_time * SWING_SPEED)
		if Input.is_action_just_pressed("drop_claw"):
			direction = Vector2.DOWN.rotated(rotation)
			dropping = true
	elif dropping:
		if ray_cast.is_colliding():
			object = ray_cast.get_collider()
			object_retract_speed = object.retract_speed
			
			object.reparent(self)
			object.position = pickup_point.position
			
			object_retracting = true
			dropping = false
			retracting = false
			print("collision")
		position += direction * DROP_SPEED *delta
		if position.y > screen_size.y - PADDING or position.x > screen_size.x/2 or position.x < -screen_size.x/2:
			dropping = false
			retracting = true
	elif retracting:
		position = position.move_toward(start_position,RETRACT_SPEED*delta)
		if position.is_equal_approx(start_position):
			position = start_position
			retracting = false
	elif object_retracting:
		print("hi")
		position = position.move_toward(start_position, object_retract_speed*delta)
		if position.is_equal_approx(start_position):
			GameManager.add_points(object.points)
			object.queue_free()
			position = start_position
			object_retracting = false
	
		
