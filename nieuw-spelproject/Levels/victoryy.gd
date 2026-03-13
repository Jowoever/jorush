extends Node

func _ready():
	$AudioStreamPlayer.play()
	await $AudioStreamPlayer.finished
	get_tree().change_scene_to_file("res://scenes/mainmen.tscn")
