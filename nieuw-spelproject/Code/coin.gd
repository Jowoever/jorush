extends Area2D

@export var value: int = 5
var picked_up = false

func _ready() -> void:
	# Only connect in code if NOT connected in editor
	# Safer approach: disconnect first to avoid duplicates
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)
	
	# Check if AnimationPlayer exists before connecting
	if has_node("AnimationPlayer") and $AnimationPlayer:
		if not $AnimationPlayer.animation_finished.is_connected(_on_animation_finished):
			$AnimationPlayer.animation_finished.connect(_on_animation_finished)
	else:
		print("Warning: No AnimationPlayer found in ", name)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not picked_up:
		picked_up = true
		print("picked up a coin!")
		
		# Add coins to main scene
		var main_scene = get_tree().current_scene
		if main_scene and main_scene.has_method("add_coins"):
			main_scene.add_coins(value)
		
		# Play sound
		if $AudioStreamPlayer and $AudioStreamPlayer.stream:
			$AudioStreamPlayer.play()
		
		# Disable collision
		$CollisionShape2D.set_deferred("disabled", true)
		
		# Play animation (only if exists)
		if has_node("AnimationPlayer") and $AnimationPlayer:
			$AnimationPlayer.play("pickup")
		else:
			# No animation, just delete after sound
			await get_tree().create_timer(0.3).timeout
			queue_free()

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "pickup":
		queue_free()
