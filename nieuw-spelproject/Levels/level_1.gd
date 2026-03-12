extends Node2D

var coins_collected = 0

func _ready():
	# Optional: Initialize UI with default values
	update_fuel_ui(100)  # Set fuel UI to full at start
	# Coin label starts at 0 (already set in scene)

func add_coins(amount):
	coins_collected += amount
	# Update coin label
	if has_node("ui/coin/Label"):
		$ui/coin/Label.text = str(coins_collected)
	else:
		print("Coin label not found!")

func update_fuel_ui(value):
	# Update fuel label
	if has_node("ui/Fuel/Label"):
		$ui/Fuel/Label.text = str(value)
	
		
	
	# Update progress bar
	var fuel_progress_bar = get_node_or_null("ui/Fuel/ProgressBar")
	if fuel_progress_bar:
		fuel_progress_bar.value = value
		
		# Optional: Change color based on fuel level
		var stylebox = fuel_progress_bar.get_theme_stylebox("fill")
		if stylebox:
			# Color transitions from red (low fuel) to green (high fuel)
			stylebox.bg_color.h = lerpf(0.0, 0.3, value / 100.0)
	else:
		print("Progress bar not found!")
	
	# Play alarm animation when fuel is empty
	var fuel_anim_player = get_node_or_null("ui/Fuel/AnimationPlayer")
	if fuel_anim_player:
		if value <= 0:
			fuel_anim_player.play("alarm")
		else:
			fuel_anim_player.play("RESET")
