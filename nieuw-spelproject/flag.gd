extends Area2D

func _ready():
	# Connect the signal manually
	body_entered.connect(_on_flag_body_entered)

func _on_flag_body_entered(body: Node2D):
	print("Signal fired! Body: ", body.name)
	
	if body.is_in_group("player"):
		print("Player touched flag!")
		get_tree().change_scene_to_file("res://Levels/level_2.tscn")
