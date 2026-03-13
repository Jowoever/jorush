extends Button



func _on_pressed() -> void:
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://scenes/info.tscn")





func _on_start_pressed() -> void:
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://Levels/level_1.tscn")
	

func _on_options_pressed() -> void:
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://scenes/options.tscn")
