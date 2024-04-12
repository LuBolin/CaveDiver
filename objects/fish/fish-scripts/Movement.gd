class_name Movement
extends CharacterBody2D

var movement_function : Callable
var collision_function : Callable

func initialise(mf : Callable, cf : Callable, initial_velocity : Vector2):
	movement_function = mf
	collision_function = cf
	velocity = initial_velocity

func move(delta) -> void:
	var v : Vector2 = movement_function.call(velocity, delta)
	var collision : KinematicCollision2D = move_and_collide(v * delta)
	if (collision):
		collision_function.call(collision)

## Generic bounce function bc I couldn't think of another way to implement
func bounce(kmbd : KinematicCollision2D):
	velocity = velocity.bounce(kmbd.get_normal())

