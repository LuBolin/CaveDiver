extends RigidBody2D


@onready var trail: Line2D = $Trail

const SPEED = 400

const LIFE_SPAN = 4
var life_remaining = LIFE_SPAN
var in_water: bool = false

func _ready():
	self.body_entered.connect(self.collision)

func launch(velocity: Vector2):
	# trail.reparent(get_parent())
	# no need to reparent, as trail is set as top level in inspector
	velocity = velocity.normalized() * SPEED
	set_linear_velocity(velocity)
	add_to_trail()

func _physics_process(delta):
	if life_remaining < 0:
		die()
		return
	var current_v = self.get_linear_velocity()
	if in_water:
		if current_v.length() < SPEED:
			self.set_linear_velocity(current_v.normalized() * SPEED)
	life_remaining -= delta

func _process(delta):
	if in_water:
		if trail.get_point_count() == 0:
			add_to_trail()
		
		var local = trail.to_local(self.global_position)
		trail.set_point_position(trail.get_point_count()-1, local)


func collision(body: Node):
	add_to_trail()

func die():
	trail.reparent(get_parent())
	# reparent on death, as trail is
	# technically still part of fish before reparenting
	self.queue_free()

func water_transition(in_water):
	self.in_water = in_water
	if in_water:
		set_gravity_scale(0)
	else:
		set_gravity_scale(0.5)

func add_to_trail():
	if not in_water:
		return
	var local = trail.to_local(self.global_position)
	if trail.get_point_count() == 0: # first time
		trail.add_point(local)
		trail.add_point(local)
	else:
		trail.add_point(local)
