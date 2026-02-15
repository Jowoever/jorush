extends Area2D

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_finishflag_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://scenes/mainmen.tscn")
