extends State


@export
var land_idle_state: State
@export
var land_move_state: State
@export
var water_idle_state: State

func enter():
	super()
	parent.velocity.x = 0

func process_physics(delta):
	parent.velocity.y += gravity * delta
	if parent.velocity.y > terminal_fall_speed:
		parent.velocity.y = terminal_fall_speed
	parent.move_and_slide()
	
	var movement = Input.get_axis("move_left", "move_right") \
		* land_move_speed
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if parent.in_water:      
		# parent.velocity.y *= 0.1
		parent.velocity.y = 0
		return water_idle_state

	if parent.is_on_floor():
		if movement != 0:
			return land_move_state
		return land_idle_state
	
	return null
