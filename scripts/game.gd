extends Node2D

const GOAL = 300

@onready var score_label: Label = $Labels/ScoreLabel
@onready var timer_label: Label = $Labels/TimerLabel
@onready var goal_label: Label = $Labels/GoalLabel

@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score_label.text = "Score: 0"
	goal_label.text = "Goal: " + str(GOAL)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score_label.text = "Score: " + str(GameManager.score)
	timer_label.text = "Time Remaining: " + str(int(timer.time_left))
