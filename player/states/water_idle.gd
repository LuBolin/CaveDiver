extends State

@export
var water_sink_state: State
@export
var water_float_state: State
@export
var water_move_state: State

func enter():
	super()
	parent.velocity.y = 0
	if Input.is_action_pressed("move_up"):
		return water_float_state

func process_physics(delta):
	if parent.velocity.y < water_idle_fall_speed:
		parent.velocity.y += delta/2.0 * water_idle_fall_speed
		if parent.velocity.y > water_idle_fall_speed:
			parent.velocity.y = water_idle_fall_speed
	parent.move_and_slide()
	return null

func process_input(event):
	if Input.is_action_pressed("move_up"):
		return water_float_state
	if Input.is_action_pressed("move_down"):
		return water_sink_state
	if int(Input.is_action_pressed("move_left")) + \
		int(Input.is_action_pressed("move_right")) == 1:
			return water_move_state
	return null
