class_name Fish
extends Node

## START HERE
## Fish class
## Attach generic Fish Skeleton and Fish Type subclass

@export var skeleton : FishSkeleton
@export var fish_type : FishType

var live : bool

func _ready():
	skeleton.install(fish_type)
	live = true

func _process(delta):
	update(delta)

## Spawner should call launch(direction) when instantiating 
func launch(direction : Vector2) -> void:
	skeleton.launch(direction, die)

func update(delta):
	if (live):
		skeleton.update(delta)

func die() -> void:
	live = false
	var trail : FishTrail = skeleton.find_child("Trail")
	trail.die()
	trail.reparent(get_parent())
	skeleton.queue_free()
