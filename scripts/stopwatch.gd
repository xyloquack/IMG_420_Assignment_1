extends CanvasLayer

var time_elapsed
var stopped = false

func start_stopwatch():
	time_elapsed = 0
	
func stop_stopwatch():
	stopped = true

func _physics_process(delta):
	if not stopped:
		time_elapsed += delta
	$Stopwatch.text = "Time: " + "%.3f" % time_elapsed
