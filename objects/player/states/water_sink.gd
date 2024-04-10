extends State

@export
var water_idle_state: State
@export
var water_move_state: State
@export
var water_float_state: State

var sink_speed: float = 100

func enter():
	super()

func process_physics(delta: float):
	parent.velocity.y = sink_speed
	
	var movement = Input.get_axis("move_left", "move_right") \
		* water_move_speed
	if movement != 0:
		parent.animations.flip_h = movement < 0
	parent.velocity.x = movement
	parent.move_and_slide()
	
	return null

func process_input(event):
	var sinking =  Input.is_action_pressed("move_down")
	var floating = Input.is_action_pressed("move_up")
	var movement = Input.get_axis("move_left", "move_right")
	if floating:
		if sinking:
			if movement == 0:
				return water_idle_state
			return water_move_state
		else:
			return water_float_state
	else:
		if not sinking:
			if movement == 0:
				return water_idle_state
			return water_move_state
	
	return null
