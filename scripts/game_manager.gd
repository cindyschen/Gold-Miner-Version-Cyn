extends Node

var score = 0
var goals = [300,1000,2000,3000]
var stage = 0
func add_points(points: int):
	score += points
	print(score)
