class_name FishSkeleton
extends Node2D

## This is a Fish. Fish loads all properties in one place.
## To alter Fish, you only need to extend abstract class FishType and implement all functions

@export var sprite : Sprite2D
@export var movement : Movement
@export var fish_trail : FishTrail

var fish_type : FishType

# not sure if need
#@export var collision : CollisionShape2D

## I will regret naming it this later
func install(ft : FishType):
	fish_type = ft

## Launch Fish
func launch(direction : Vector2, die : Callable) -> void:
	fish_type.initialise(fish_type, sprite, movement, fish_trail, direction, die)

func update(delta) -> void:
	movement.move(delta)
	sprite.update(movement.get_velocity().angle())
	fish_trail.update(delta)
