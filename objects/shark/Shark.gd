extends RigidBody2D

@onready var patrol_route = $"../PatrolRoute"
@onready var sprite = $AnimatedSprite2D
@onready var kill_area = $KillZone

@export var speed: float = 10

var patrol_point_count: int
var patrol_points = []
var current_index = 0
var done = false

func _ready():
	var point_count = patrol_route.get_point_count()
	if point_count == 0:
		self.queue_free()
		return
	patrol_point_count = point_count
	var parent = get_parent()
	for i in range(point_count):
		var point = patrol_route.get_point_position(i)
		point = parent.to_global(point)
		patrol_points.append(point)
	self.global_position = patrol_points[0]
	current_index = 1
	patrol_route.set_visible(false)

func _process(delta):
	if get_linear_velocity().x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

func _physics_process(delta):
	if done or patrol_point_count == 0:
		set_freeze_enabled(true)
		return
	var coverable = speed * delta
	var current_point = patrol_points[current_index]
	var to_travel = current_point - self.global_position
	if to_travel.length() < coverable:
		current_index +=1
		if patrol_route.is_closed():
			current_index = current_index % patrol_point_count
		else:
			if current_index >= patrol_point_count:
				done = true
	self.set_linear_velocity(to_travel.normalized() * speed)


func _on_kill_zone_body_entered(body):
	if body == self:
		return
	if body is Fish:
		body.die()
	#body.queue_free()
