extends State

@export
var land_jump_state: State
@export
var water_idle_state: State
@export
var water_move_state: State
@export
var water_sink_state: State

func enter():
	super()

func process_physics(delta: float):
	parent.velocity.y = -water_float_speed
	
	var movement = Input.get_axis("move_left", "move_right") \
		* water_move_speed
	if movement != 0:
		parent.animations.flip_h = movement < 0
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if not Input.is_action_pressed("move_up"):
		if movement == 0:
			return water_idle_state
		else:
			return water_move_state

	# floated out
	if not parent.in_water():
		parent.oxygen_buffer_left = parent.oxygen_buffer
		return land_jump_state
	
	return null
