extends CanvasLayer

var world = preload("uid://d0h07t5wtpr70")

func _on_start_button_pressed() -> void:
	print("Start!")
	get_tree().change_scene_to_packed(world)
