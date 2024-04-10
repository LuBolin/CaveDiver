class_name Fish
extends Node2D

## This is a Fish. Fish loads all properties in one place.
## To alter Fish, you only need to extend abstract class FishType and implement all functions

@export var fish_type : FishType
@export var sprite : Sprite2D
@export var movement : Movement

# not sure if need
#@export var collision : CollisionShape2D

# TODO
#@export var trail

func _process(delta):
	fish_type.update(delta)

## TODO temporary to fit code, remove later
func launch(direction : Vector2):
	fish_type.initialise(fish_type, sprite, movement, direction)
