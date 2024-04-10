class_name Fish
extends Node

## START HERE
## Fish class
## Attach generic Fish Skeleton and Fish Type subclass

@export var skeleton : FishSkeleton
@export var fish_type : FishType

func _ready():
	skeleton.install(fish_type)

func _process(delta):
	fish_type.update(delta)

## Spawner should call launch(direction) when instantiating 
func launch(direction : Vector2) -> void:
	skeleton.launch(direction)
