extends Node2D

signal death
signal restart

func _ready():
	print(self)
	$Player.position = $PlayerStartPosition.position

func _on_death():
	print("Death Screen!")
	$RestartScreen.death_screen()

func _on_restart():
	print("Restarting!")
	$Player.position = $PlayerStartPosition.position
	$Player.velocity = Vector2.ZERO
