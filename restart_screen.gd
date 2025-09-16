extends CanvasLayer

var world

func _ready():
	world = get_tree().get_root().get_node("World")
	hide()

func death_screen():
	get_tree().paused = true
	show()

func _on_restart_button_pressed() -> void:
	print("Restart!")
	get_tree().paused = false
	world.emit_signal("restart")
	hide()
