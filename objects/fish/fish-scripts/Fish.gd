class_name Fish
extends CharacterBody2D

## START HERE
## Fish class
## Attach generic Fish Skeleton and Fish Type subclass

@export var fish_type : FishType
@export var fish_skeleton : FishSkeleton

var waters_area

var live : bool
var speed : int

func _ready():
	fish_type.initialise(self, fish_skeleton, die)
	var root_node = get_tree().root.get_node('LevelRoot')
	waters_area = root_node.get_node(^'World/Water_Area')

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

func in_water():
	var in_water = waters_area.overlaps_body(self)
	return in_water

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
	if (not in_water()):
		gravity += Vector2(0, 10) * delta
		v = velocity + gravity
		velocity = v.normalized() * speed
	else:
		v.normalized() * speed
		gravity = Vector2(0, 0)
	return v
