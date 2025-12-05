extends Popup

func _process(delta):
		if Input.is_action_pressed("escape"):
			visible = true
		
