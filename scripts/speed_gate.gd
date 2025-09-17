extends Area2D

@export var direction: int

func _ready():
	var polygon2D = Polygon2D.new()
	polygon2D.position = -position
	polygon2D.polygon = PackedVector2Array([Vector2(position.x - $CollisionShape2D.shape.size.x / 2, position.y - $CollisionShape2D.shape.size.y / 2), 
											Vector2(position.x + $CollisionShape2D.shape.size.x / 2, position.y - $CollisionShape2D.shape.size.y / 2),
											Vector2(position.x + $CollisionShape2D.shape.size.x / 2, position.y + $CollisionShape2D.shape.size.y / 2),
											Vector2(position.x - $CollisionShape2D.shape.size.x / 2, position.y + $CollisionShape2D.shape.size.y / 2)])
	polygon2D.color = Color(1, 1, 0, 0.5)
	add_child(polygon2D)

func _on_body_entered(body: Node2D) -> void:
	body.emit_signal("boost", direction)
