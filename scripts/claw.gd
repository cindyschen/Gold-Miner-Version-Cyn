extends Node2D

const SWING_ANGLE= 80.0
const SWING_SPEED= 2.0
const DROP_SPEED = 500
const RETRACT_SPEED = 1000
const PADDING = 100
const DYNAMITE= preload("res://scenes/objects/dynamite.tscn")
const DYNAMITE_SPEED = 1000
const LEFT_CLOSED_CLAW= preload("res://assets/sprites/leftclosedclaw.png")
const RIGHT_CLOSED_CLAW = preload("res://assets/sprites/rightclosedclaw.png")
const LEFT_OPEN_CLAW= preload("res://assets/sprites/clawleft.png")
const RIGHT_OPEN_CLAW = preload("res://assets/sprites/clawright.png")

var direction = Vector2.DOWN
var dropping = false
var retracting = false
var object_retracting = false
var swing_time = 0
var start_position: Vector2
var global_start_position: Vector2
var object_retract_speed = 600
var object: Area2D

@onready var dynamite_folder: Node2D = $"../Dynamite"
@onready var line: Line2D = $Line2D
@onready var ray_cast: RayCast2D = $ClawRight/RayCast2D
@onready var pickup_point: Marker2D = $Marker2D
@onready var claw_left: Sprite2D = $ClawLeft
@onready var claw_right: Sprite2D = $ClawRight

func _ready() -> void:
	start_position = position
	global_start_position = global_position

func _process(delta: float) -> void:
	var screen_size = get_viewport_rect().size
	line.clear_points()
	line.add_point(Vector2.ZERO)
	line.add_point(to_local(global_start_position))
	if not dropping and not retracting and not object_retracting:
		swing_time += delta
		rotation = deg_to_rad(SWING_ANGLE) * sin(swing_time * SWING_SPEED)
		if Input.is_action_just_pressed("drop_claw"):
			direction = Vector2.DOWN.rotated(rotation)
			dropping = true
	elif dropping:
		if ray_cast.is_colliding():
			object = ray_cast.get_collider()
			object_retract_speed = object.retract_speed * GameManager.strength
			
			object.reparent(self)
			claw_left.z_index = 2
			claw_left.texture = LEFT_CLOSED_CLAW
			claw_right.texture = RIGHT_CLOSED_CLAW
			
			object.position = pickup_point.position - object.get_node("topPoint").position
			
			object.rotation = 0
			
			object_retracting = true
			dropping = false
			retracting = false
			print("collision")
		position += direction * DROP_SPEED *delta
		if position.y > screen_size.y/2 or position.x > screen_size.x/2 or position.x < -screen_size.x/2:
			dropping = false
			retracting = true
	elif retracting:
		position = position.move_toward(start_position,RETRACT_SPEED*delta)
		if position.is_equal_approx(start_position):
			position = start_position
			retracting = false
	elif object_retracting:
		object.z_index = 1
		if Input.is_action_just_pressed("throw_dynamite") and GameManager.dynamite > 0:
			print("dynamite thrown!")
			var dynamite = DYNAMITE.instantiate()
			dynamite_folder.add_child(dynamite)
			dynamite.dynamite_hit.connect(_on_dynamite_hit)
			dynamite.global_position = global_start_position
			dynamite.direction = Vector2.DOWN.rotated(rotation)
			GameManager.use_dynamite()
		position = position.move_toward(start_position, object_retract_speed*delta)
		if position.is_equal_approx(start_position):
			GameManager.add_points(object.points)
			object.queue_free()
			position = start_position
			object_retracting = false
			claw_left.texture = LEFT_OPEN_CLAW
			claw_right.texture = RIGHT_OPEN_CLAW
			
func _on_dynamite_hit():
	object_retracting = false
	retracting = true
	claw_left.texture = LEFT_OPEN_CLAW
	claw_right.texture = RIGHT_OPEN_CLAW
	
		
