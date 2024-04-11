class_name FishTypeSinusoidal
extends FishType

func _init():
	speed = 100
	size = 0.3

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
	return dir

## Define what should be done on collision with a KinematicCollision2D object
func collision_function(kmbd : KinematicCollision2D) -> void:
	if(kmbd.get_collider().name == "Shark"):
		die.call()
	movement.bounce(kmbd)	#bounce no matter what
	var angle = kmbd.get_angle()
	var offset = period - 2 * angle
	cycle += period / 2
