extends CanvasLayer

var world

func _ready():
	hide()
	world = get_tree().get_root().get_node("World")

func show_win(time_taken):
	get_tree().paused = true
	show()
	$TimeTaken.text = "Time taken: " + "%.3f" % time_taken

func _on_button_pressed():
	get_tree().paused = false
	world.emit_signal("restart")
