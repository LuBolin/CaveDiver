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
	if parent.in_water:
		parent.velocity.y = -water_float_speed
	else:
		parent.velocity.y = 0
	
	var movement = Input.get_axis("move_left", "move_right") \
		* water_move_speed
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if parent.in_water and movement != 0:
		return water_move_state
	
	if not Input.is_action_pressed("move_up"):
		if movement == 0:
			return water_idle_state
		else:
			return water_move_state

	if Input.is_action_just_pressed("jump"):
		if not parent.in_water:
			return land_jump_state
	
	return null
