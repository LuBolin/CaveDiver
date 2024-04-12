class_name FishSprite
extends Sprite2D

func update(angle) -> void:
	rotation = angle
	if (angle > PI / 2 || angle < -PI / 2):
		scale = Vector2(1, -1)
	else:
		scale = Vector2(1, 1)
