extends Node2D

var coins_collected = 0

func _ready():
	# The UI is already in the scene, just find it
	var ui_node = get_ui_node()
	if ui_node:
		print("Found UI node: ", ui_node.name)
		update_fuel_ui(100)
	else:
		print("UI node not found in scene!")
		
		
func add_coins(amount):
	coins_collected += amount
	# Update coin label
	if has_node("ui/coin/Label"):
		$ui/coin/Label.text = str(coins_collected)
	else:
		print("Coin label not found!")
		
func get_ui_node():
	# Try to find UI node by common names
	for child in get_children():
		if child.name in ["ui", "UI", "Ui", "ui2", "UI2"]:
			return child
		
		# Also check if it's the first child with "ui" in the name
		if "ui" in child.name.to_lower():
			return child
	
	return null

# Rest of your functions (add_coins, update_fuel_ui) remain the same

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
