class_name FishTypeSinusoidal
extends FishType

func _init():
	speed = 50
	size = 0.3
	stamina = 1000

## Define how the fish moves
var cycle : float = 0
var period : float = 5
func move_function(velocity : Vector2, delta) -> Vector2:
	
	cycle += delta * period
	if (cycle > 2 * PI):
		cycle -= 2 * PI
	var speed : float = velocity.length()
	var direction : float = velocity.angle()
	var dir : Vector2 = Vector2(cycle, cycle * cos(cycle)).normalized().rotated(direction) * speed
	return stamina_drain(dir, delta)

## Define what should be done on collision with a KinematicCollision2D object
func collision_function(kmbd : KinematicCollision2D) -> void:
	fish.bounce(kmbd)	#bounce no matter what
	var angle = kmbd.get_angle()
	var offset = period - 2 * angle
	cycle += period / 2
