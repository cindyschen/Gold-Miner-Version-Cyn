extends CharacterBody2D

@onready var capybara_animations: AnimatedSprite2D = $CapybaraAnimations

func pull_animation(speed: float):
	capybara_animations.speed_scale = speed
	if capybara_animations.animation != "pulling":
		capybara_animations.play("pulling")
	
func idle_animation():
	capybara_animations.speed_scale = 1
	if capybara_animations.animation != "idle":
		capybara_animations.play("idle")
	
