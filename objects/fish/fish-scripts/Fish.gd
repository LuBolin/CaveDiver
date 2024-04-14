class_name Fish
extends CharacterBody2D

## START HERE
## Fish class
## Attach generic Fish Skeleton and Fish Type subclass

@export var fish_type : FishType
@export var fish_texture: Texture2D
@export var sprite : Sprite2D
@export var fish_trail : FishTrail
@onready var oxygen_light: PointLight2D = $OxygenLight

var live : bool

func _ready():
	live = true

func _process(delta):
	update(delta)

## Spawner should call launch(direction) when instantiating 
func launch(direction : Vector2) -> void:
	fish_type.initialise(self, sprite, fish_trail, direction, die)
	sprite.set_texture(fish_texture)

func update(delta):
	if (live):
		move(delta)
		sprite.update(get_velocity().angle())
		fish_trail.update(delta)

func die() -> void:
	live = false
	var trail : FishTrail = find_child("Trail")
	trail.die()
	trail.reparent(get_parent())
	queue_free()

var movement_function : Callable
var collision_function : Callable

func move_install(mf : Callable, cf : Callable, initial_velocity : Vector2):
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

