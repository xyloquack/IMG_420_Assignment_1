extends Node2D

var PLAYER = load("uid://c4ofxsbndmexq")

func _ready():
	var player = PLAYER.instantiate()
	player.global_position = Vector2(0, 0)
	add_child(player)
