extends Area2D

@export var fuel_amount: int = 25  # How much fuel to give (renamed from 'value' for clarity)
var picked_up = false

func _ready() -> void:
	# Only connect in code if NOT connected in editor
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)
	
	# Check if AnimationPlayer exists before connecting
	if has_node("AnimationPlayer") and $AnimationPlayer:
		if not $AnimationPlayer.animation_finished.is_connected(_on_animation_finished):
			$AnimationPlayer.animation_finished.connect(_on_animation_finished)
	else:
		print("Warning: No AnimationPlayer found in ", name)

# In iranianoil.gd, line 24
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not picked_up:
		picked_up = true
		
		# Call refuel with NO arguments
		if body.has_method("refuel"):
			body.refuel()  # Remove fuel_amount
			print("Refueled player to full")
		
		# Rest of your code...
		
		# Play sound
		if $AudioStreamPlayer and $AudioStreamPlayer.stream:
			$AudioStreamPlayer.play()
		
		# Disable collision
		$CollisionShape2D.set_deferred("disabled", true)
		
		# Play animation (only if exists)
		if has_node("AnimationPlayer") and $AnimationPlayer:
			$AnimationPlayer.play("refuel")
		else:
			# No animation, just delete after sound
			await get_tree().create_timer(0.3).timeout
			queue_free()

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "refuel":
		queue_free()
