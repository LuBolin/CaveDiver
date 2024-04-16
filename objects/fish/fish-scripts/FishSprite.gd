class_name FishSprite
extends Sprite2D

func update(angle) -> void:
	if (angle > PI / 2 || angle < -PI / 2):
		scale = Vector2(1, -1)
		angle -= PI/4.0
	else:
		scale = Vector2(1, 1)
		angle += PI/4.0
	rotation = angle
