extends Popup

var popup = 0

func _process(_delta):
		if Input.is_action_just_pressed("escape"):
			if  popup == 0:
				popup = 1
				visible = true
			else:
				popup = 0
				visible = false
func _on_close_pressed() -> void:
	visible = false
		
