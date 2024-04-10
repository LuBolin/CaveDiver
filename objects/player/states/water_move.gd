extends State

@export
var land_jump_state: State
@export
var water_idle_state: State
@export
var water_float_state: State
@export
var water_sink_state: State


func enter():
	super()

func process_physics(delta):
	var sinking =  Input.is_action_pressed("move_down")
	var floating = Input.is_action_pressed("move_up")
	if not sinking and not floating:
		parent.velocity.y = water_idle_fall_speed
	elif sinking:
		parent.velocity.y = water_sink_speed
	elif floating:
		parent.velocity.y = -water_float_speed
	
	var movement = Input.get_axis("move_left", "move_right") \
		* land_move_speed
	if movement != 0:
		parent.animations.flip_h = movement < 0
	parent.velocity.x = movement
	parent.move_and_slide()

	# floated out
	if not parent.in_water():
		parent.oxygen_buffer_left = parent.oxygen_buffer
		return land_jump_state
		
	if movement == 0:
		return water_idle_state
		
	return null

func process_input(event):
	var movement = Input.get_axis("move_left", "move_right")
	if movement == 0:
		if Input.is_action_pressed("move_up"):
			return water_float_state
		if Input.is_action_pressed("move_down"):
			return water_sink_state

	return null