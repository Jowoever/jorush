extends Button



func _on_pressed() -> void:
	$Click.play()
	get_tree().change_scene_to_file("res://scenes/info.tscn")
	




func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/jonoround.tscn")
	$Click.play()

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/options.tscn")
	$Click.play()
