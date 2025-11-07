extends Button



func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/info.tscn")





func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/jonoround.tscn")
