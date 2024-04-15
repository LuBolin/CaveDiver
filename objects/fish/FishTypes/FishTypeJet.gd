class_name FishTypeJet
extends FishType

func _init():
	speed = 700
	size = 0.3

## Define how the fish moves
var multiplier : float = 10
var decayRate : float = 0.99
func move_function(velocity : Vector2, delta) -> Vector2:
	multiplier = multiplier * (decayRate ** (1.0-delta))
	return velocity * multiplier

## Define what should be done on collision with a KinematicCollision2D object
func collision_function(kmbd : KinematicCollision2D) -> void:
	fish.bounce(kmbd)	#bounce no matter what
