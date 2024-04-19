class_name FishType
extends Node

## Abstract class FishType defines attributes of different kinds of Fish
## Top portion is for common variables and functions. Add bottom functions and initialise variables
## See FishTypeBasic for example

enum FishTypeEnum {
	Basic,
	Jet,
	Sine,
	Glow
}

## FishType agnostic variables and functions
var fish : Fish
var fish_skeleton : FishSkeleton
var die : Callable
@export var fish_sprite_frames: SpriteFrames
@export var fish_trail_gradient : Gradient
@export var fish_ammo_type: FishTypeEnum

func initialise(f : Fish, skeleton : FishSkeleton, d : Callable) -> void:
	fish = f
	fish_skeleton = skeleton
	die = d
	fish.scale = Vector2(size, size)
	fish.move_install(move_function, collision_function, speed)
	fish_skeleton.install(fish, fish_sprite_frames, fish_trail_gradient, brightness)

## FishType variant variables and functions
## Use _init to initialise these variables
var speed : int = 0
var size : float = 1
var stamina : float = 100
var brightness : float = 0.1


## Define how the fish moves
func move_function(velocity : Vector2, delta) -> Vector2:
	return Vector2(0, 0)

## Define what should be done on collision with a KinematicCollision2D object
func collision_function(kmbd : KinematicCollision2D) -> void:
	pass

func stamina_drain(v : Vector2, delta) -> Vector2:
	stamina -= delta * speed
	if (stamina < 0):
		speed = max(speed - delta, 0)
		die.call()
		return v.normalized() * speed
	else:
		return v
