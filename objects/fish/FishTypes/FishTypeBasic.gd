class_name FishTypeBasic
extends FishType

func _init():
	speed = 30
	size = 0.3

## Define how the fish moves
func move_function(velocity : Vector2, delta) -> Vector2:
	return velocity

## Define what should be done on collision with a KinematicCollision2D object
func collision_function(kmbd : KinematicCollision2D) -> void:
	fish.bounce(kmbd)	#bounce no matter what
