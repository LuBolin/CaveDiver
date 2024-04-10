extends State

@export
var water_idle_state: State
@export
var water_float_state: State
@export
var water_sink_state: State

func enter():
	super()

func process_physics(delta):
	parent.velocity.y = water_idle_fall_speed
	var movement = Input.get_axis("move_left", "move_right") \
		* land_move_speed
	if movement != 0:
		parent.animations.flip_h = movement < 0
	parent.velocity.x = movement
	parent.move_and_slide()

	if movement == 0:
		return water_idle_state
	
	return null

func process_input(event):
	if Input.is_action_pressed("move_up"):
		return water_float_state
	if Input.is_action_pressed("move_down"):
		return water_sink_state

	return null
