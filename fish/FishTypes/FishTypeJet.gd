class_name FishTypeJet
extends FishType

func _init():
	speed = 700
	size = 1

## Define how the fish moves
var multiplier : float = 10
var decay_rate : float = 0.99
var windup : float = 1
func move_function(velocity : Vector2, delta) -> Vector2:
	if (windup < 0):
		multiplier = multiplier * (decay_rate ** (1.0-delta))
		return stamina_drain(velocity * multiplier, delta)
	else:
		windup -= delta
		return velocity.normalized() * - (decay_rate ** (1.0-delta)) * 10


## Define what should be done on collision with a KinematicCollision2D object
func collision_function(kmbd : KinematicCollision2D) -> void:
	fish.bounce(kmbd)	#bounce no matter what
