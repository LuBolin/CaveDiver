class_name FishTypeBasic
extends FishType

func _init():
	size = 1
	speed = 30
	stamina = 500

## Define how the fish moves
func move_function(velocity : Vector2, delta) -> Vector2:
	return stamina_drain(velocity, delta)

## Define what should be done on collision with a KinematicCollision2D object
func collision_function(kmbd : KinematicCollision2D) -> void:
	fish.bounce(kmbd)	#bounce no matter what