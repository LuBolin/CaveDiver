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

var waters_area

var live : bool
var speed : int

func _ready():
	speed = fish_type.initialise(self, sprite, fish_trail, die)
	var root_node = get_tree().root.get_child(0)
	waters_area = root_node.get_node(^'World/Water_Area')

func _process(delta):
	update(delta)

## Spawner should call launch(direction) when instantiating 
func launch(direction : Vector2) -> void:
	live = true
	sprite.set_texture(fish_texture)
	velocity = direction.normalized() * speed

func update(delta):
	move(delta)
	if (live):
		sprite.update(get_velocity().angle())
		fish_trail.update(delta)
	#if (Input.is_key_pressed(KEY_ESCAPE)):
	#	pick_up()

func in_water():
	var in_water = waters_area.overlaps_body(self)
	return in_water

func die() -> void:
	live = false
	fish_trail.die()
	movement_function = dead_move

func pick_up():
	destroy()

func destroy():
	die()
	queue_free()

var movement_function : Callable
var collision_function : Callable

func move_install(mf : Callable, cf : Callable):
	movement_function = mf
	collision_function = cf

func move(delta) -> void:
	var v = movement_function.call(velocity, delta)
	var collision : KinematicCollision2D = move_and_collide(v * delta)
	if (collision and live):
		collision_function.call(collision)

## Generic bounce function bc I couldn't think of another way to implement
func bounce(kmbd : KinematicCollision2D):
	velocity = velocity.bounce(kmbd.get_normal())

func dead_move(velocity : Vector2, delta) -> Vector2:
	return Vector2(0, -20)
