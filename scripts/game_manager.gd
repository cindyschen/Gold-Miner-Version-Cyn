extends Node

const MAX_DYNAMITES = 20

var score = 0
var goals = [300,1000,2000,3000]
var stage = 0
var dynamite = 0
var next_stage: String = "res://scenes/stage_2.tscn"
var strength = 1
var time = 30

signal dynamite_changed()
signal money_changed

func add_points(points: int):
	score += points
	print(score)
	money_changed.emit()
	
func subtract_points(points: int):
	score -= points
	print(score)
	money_changed.emit()
	
func use_dynamite():
	dynamite -= 1
	dynamite_changed.emit()
	
func add_dynamite():
	dynamite+= 1
	dynamite_changed.emit()
	
func energy_drink():
	strength = 2
	
func hourglass():
	time = 45
	
