extends Area2D

@export var value: int = 5
var picked_up = false

func _ready() -> void:
	# Connect signals
	body_entered.connect(_on_body_entered)
	$AnimationPlayer.animation_finished.connect(_on_animation_finished)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not picked_up:
		picked_up = true
		
		# Add coins to main scene
		var main_scene = get_tree().current_scene
		if main_scene and main_scene.has_method("add_coins"):
			main_scene.add_coins(value)
		
		# Play sound
		if $AudioStreamPlayer and $AudioStreamPlayer.stream:
			$AudioStreamPlayer.play()
		
		# Disable collision
		$CollisionShape2D.set_deferred("disabled", true)
		
		# Play animation
		$AnimationPlayer.play("pickup")

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "pickup":
		queue_free()
