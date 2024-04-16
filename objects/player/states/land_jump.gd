extends State


@export
var land_fall_state: State
@export
var land_idle_state: State
@export
var land_move_state: State
@export
var water_idle_state: State

var jump_force: float = 400

func enter():
	super()
	parent.velocity.y = -jump_force

func process_physics(delta: float):
	parent.velocity.y += gravity * delta
	var movement = Input.get_axis("move_left", "move_right") \
		* land_move_speed
	parent.velocity.x = movement
	parent.move_and_slide()

	if parent.in_water:
		return water_idle_state
	
	if parent.velocity.y > 0:
		return land_fall_state
	
	if parent.is_on_floor():
		if movement != 0:
			return land_move_state
		return land_idle_state
	
	return null
