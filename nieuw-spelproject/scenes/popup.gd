extends Popup

func _process(_delta):
		if Input.is_action_pressed("escape"):
			visible = true
func _on_close_pressed() -> void:
	visible = false
		
