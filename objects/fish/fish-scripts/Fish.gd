class_name Fish
extends CharacterBody2D

## START HERE
## Fish class
## Attach generic Fish Skeleton and Fish Type subclass

# @export var fish_type : FishType
@onready var fish_type : FishType = $FishType
# @export var fish_skeleton : FishSkeleton
@onready var fish_skeleton : FishSkeleton = $FishSkeleton

var live : bool
var speed : int
var in_water: bool = true

func _ready():
	fish_type.initialise(self, fish_skeleton, die)
	var root_node = get_tree().root.get_node('LevelRoot')

func _process(delta):
	update(delta)

## Spawner should call launch(direction) when instantiating 
func launch(direction : Vector2) -> void:
	live = true
	velocity = direction.normalized() * speed

func update(delta):
	move(delta)
	if (live):
		fish_skeleton.update(get_velocity().angle(), delta)


func die() -> void:
	live = false
	fish_skeleton.die()
	movement_function = dead_move

func pick_up():
	destroy()

func destroy():
	die()
	queue_free()

var movement_function : Callable
var collision_function : Callable

func move_install(mf : Callable, cf : Callable, sp : int):
	movement_function = mf
	collision_function = cf
	speed = sp

func move(delta) -> void:
	var v = movement_function.call(velocity, delta)
	v = gravity_adjust(v, delta)
	var collision : KinematicCollision2D = move_and_collide(v * delta)
	if (collision and live):
		collision_function.call(collision)

## Generic bounce function bc I couldn't think of another way to implement
func bounce(kmbd : KinematicCollision2D):
	velocity = velocity.bounce(kmbd.get_normal())

func dead_move(velocity : Vector2, delta) -> Vector2:
	return Vector2(0, -20)

var gravity : Vector2 = Vector2(0, 0)
func gravity_adjust(v : Vector2, delta) -> Vector2:
	if (not in_water):
		gravity += Vector2(0, 10) * delta
		v = velocity + gravity
		velocity = v.normalized() * speed
	else:
		v.normalized() * speed
		gravity = Vector2(0, 0)
	return v
