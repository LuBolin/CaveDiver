class_name FishType
extends Node

## Abstract class FishType defines attributes of different kinds of Fish

## FishType agnostic variables and functions
var fish_type : FishType
var sprite : FishSprite
var movement : Movement
var fish_trail : FishTrail

func initialise(ft : FishType, sp: FishSprite, mv: Movement, f_trail : FishTrail, direction : Vector2) -> void:
	fish_type = ft
	sprite = sp
	movement = mv
	fish_trail = f_trail
	movement.scale = Vector2(size, size)
	movement.initialise(move_function, collision_function, direction.normalized() * speed)
	
func update(delta) -> void:
	movement.move(delta)
	sprite.update(movement.get_velocity().angle())
	fish_trail.update(delta)

## FishType variant variables and functions
## Use _init to initialise these variables
var speed : int = 0
var size : float = 1 # size of fish maybe in future


## Define how the fish moves
func move_function(velocity : Vector2, delta) -> Vector2:
	return Vector2(0, 0)

## Define what should be done on collision with a KinematicCollision2D object
func collision_function(kmbd : KinematicCollision2D) -> void:
	pass
