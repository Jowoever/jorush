extends Node2D

var coins_collected = 0

func add_coins(amount):
	coins_collected += amount
	$ui/TextureRect/Label.text = str(coins_collected)
	
func update_fuel_UI(value):
	
	var fuel_progress_bar : ProgressBar = $UI/Fuel/ProgressBar
	var fuel_anim_player : AnimationPlayer = $UI/Fuel/AnimationPlayer
	
	#update progress bar with given value
	fuel_progress_bar.value = value
	
	#change color hue as the fuel runs out
	var stylebox = fuel_progress_bar.get_theme_stylebox("fill")
	stylebox.bg_color.h = lerpf(0, 0.3, value / 100)
	
	#play alarm animation
	if value == 0:
		fuel_anim_player.play("alarm")
	else:
		fuel_anim_player.play("RESET")
