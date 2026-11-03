extends Node2D

@onready var score_label: Label = $Labels/ScoreLabel
@onready var timer_label: Label = $Labels/TimerLabel
@onready var goal_label: Label = $Labels/GoalLabel
@onready var lost_screen: Control = $LostScreen
@onready var win_screen: Control = $WinScreen
@onready var timer: Timer = $Timer
@onready var claw: Node2D = $claw
@onready var prize_label: Label = $Labels/PrizeLabel
@onready var prize_timer: Timer = $Labels/PrizeLabel/PrizeTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	claw.object_collected.connect(_on_object_collected)
	timer.wait_time = GameManager.time
	timer.start()
	score_label.text = "Score: " + str(GameManager.score)
	goal_label.text = "Goal: " + str(GameManager.goals[GameManager.stage])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score_label.text = "Money: " + str(GameManager.score)
	timer_label.text = "Time Remaining: " + str(int(timer.time_left))
	
func _on_object_collected(object_points:int):
	print("got here")
	print(object_points)
	prize_label.show()
	prize_label.text = "$" + str(object_points)
	
	prize_timer.start()
	await prize_timer.timeout
	prize_label.hide()
	

func _on_timer_timeout() -> void:
	GameManager.strength = 1
	GameManager.time = 30
	GameManager.diamond_multiplier = 1
	GameManager.rock_multiplier = 1
	get_tree().paused = true
	if GameManager.score >= GameManager.goals[GameManager.stage]:
		win_screen.show()
		GameManager.stage += 1
	else:
		lost_screen.show()
		GameManager.stage = 0
		GameManager.score = 0
