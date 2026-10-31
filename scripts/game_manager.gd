extends Node

const MAX_DYNAMITES = 20

var score = 0
var goals = [300,1000,2000,3000]
var stage = 0
var dynamite = 0
var strength = 1
var time = 30

var stage_variants = {
	0:[
		"res://scenes/stage_1a.tscn",
		"res://scenes/stage_1b.tscn"
	],
	1:[
		"res://scenes/stage_2a.tscn",
		"res://scenes/stage_2b.tscn"
	],
	2:[
		"res://scenes/stage_3a.tscn",
		"res://scenes/stage_3b.tscn"
	],
	3:[
		"res://scenes/stage_4a.tscn",
		"res://scenes/stage_4b.tscn"
	]
}

signal dynamite_changed()
signal money_changed

func restart():
	stage = 0
	score = 0
	dynamite = 0
	strength = 1
	time = 30
	next_stage()

func next_stage():
	get_tree().change_scene_to_file(stage_variants[stage].pick_random())

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
	
