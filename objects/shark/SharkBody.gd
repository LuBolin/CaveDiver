extends RigidBody2D

@onready var patrol_route = $".."
@onready var sprite = $AnimatedSprite2D
@onready var kill_area = $KillZone
@onready var chomp = $chomp

var patrol_point_count: int
var patrol_points = []
var current_index = 0
var done = false

var speed: float

func _ready():
	var parent_data_container: Shark = get_parent()
	speed = parent_data_container.speed
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
	if patrol_points.size() > 1:
		current_index = 1
	patrol_route.set_default_color(Color.TRANSPARENT)
	
	# after chomping
	sprite.animation_finished.connect(play_default_anim)

func _process(delta):
	if get_linear_velocity().x > 0:
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
		if body.live:
			body.die()
			sprite.play("chomp")
			chomp.play()
	if body is Player:
		if body.alive:
			body.die()
			sprite.play("chomp")
			chomp.play()

func play_default_anim():
	if not (sprite.get_animation() == "default"):
		sprite.play("default")
