class_name FishType
extends Node

## Abstract class FishType defines attributes of different kinds of Fish

## FishType agnostic variables and functions
var fish_type : FishType
var sprite : Sprite2D
var movement : Movement

func initialise(ft : FishType, sp: Sprite2D, mv: Movement, direction : Vector2) -> void:
	fish_type = ft
	sprite = sp
	movement = mv
	movement.scale = Vector2(size, size)
	movement.initialise(move_function, collision_function, direction.normalized() * speed)
	
func update(delta) -> void:
	movement.move(delta)

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
