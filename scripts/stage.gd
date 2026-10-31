extends Node2D

@onready var score_label: Label = $Labels/ScoreLabel
@onready var timer_label: Label = $Labels/TimerLabel
@onready var goal_label: Label = $Labels/GoalLabel
@onready var lost_screen: Control = $LostScreen
@onready var win_screen: Control = $WinScreen

@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score_label.text = "Score: " + str(GameManager.score)
	goal_label.text = "Goal: " + str(GameManager.goals[GameManager.stage])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score_label.text = "Money: " + str(GameManager.score)
	timer_label.text = "Time Remaining: " + str(int(timer.time_left))

func _on_timer_timeout() -> void:
	GameManager.strength = 1
	get_tree().paused = true
	if GameManager.score >= GameManager.goals[GameManager.stage]:
		win_screen.show()
		GameManager.stage += 1
	else:
		lost_screen.show()
		GameManager.stage = 0
		GameManager.score = 0
