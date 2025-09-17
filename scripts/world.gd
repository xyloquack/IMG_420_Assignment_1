extends Node2D

signal death
signal restart
signal win

func _ready():
	print(self)
	$Player.position = $PlayerStartPosition.position
	$HUD.start_stopwatch()

func _on_death():
	print("Death Screen!")
	$RestartScreen.death_screen()

func _on_restart():
	$HUD.show()
	$WinScreen.hide()
	print("Restarting!")
	$Player.position = $PlayerStartPosition.position
	$Player.velocity = Vector2.ZERO
	$HUD.start_stopwatch()

func _on_win():
	$HUD.hide()
	$WinScreen.show_win($HUD.time_elapsed)
