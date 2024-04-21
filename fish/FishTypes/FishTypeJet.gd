class_name FishTypeJet
extends FishType

func _init():
	speed = 450
	size = 1
	stamina = 250

## Define how the fish moves
var multiplier : float = 10
var decay_rate : float = 0.99
var windup : float = 1
var launch_dirn: Vector2
func move_function(velocity : Vector2, delta) -> Vector2:
	if (windup < 0):
		multiplier = multiplier * (decay_rate ** (1.0-delta))
		velocity = velocity.normalized() * multiplier * speed
		return stamina_drain(velocity, delta)
	else:
		windup -= delta
		if windup < 0:
			velocity = launch_dirn.normalized() * multiplier * speed
		else:
			var tentative = velocity.normalized() * - (decay_rate ** (1.0-delta)) * 10
			var angle = abs(launch_dirn.angle_to(tentative))
			var diff = abs(PI - angle)
			if diff < deg_to_rad(10):
				velocity = tentative
			else:
				velocity = launch_dirn.normalized()*0.01
		return velocity

## Define what should be done on collision with a KinematicCollision2D object
func collision_function(kmbd : KinematicCollision2D) -> void:
	if (windup < 0):
		fish.bounce(kmbd)	#bounce no matter what
