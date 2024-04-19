extends State


@export
var land_fall_state: State
@export
var land_jump_state: State
@export
var land_move_state: State
@export
var water_idle_state: State

func enter():
	super()
	parent.velocity.x = 0

func process_physics(delta):
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if parent.in_water:
		return water_idle_state
	if not parent.is_on_floor():
		return land_fall_state
	return null

func process_input(event):
	if Input.is_action_just_pressed("jump") \
		and parent.is_on_floor():
			return land_jump_state
	if int(Input.is_action_pressed("move_left")) + \
		int(Input.is_action_pressed("move_right")) == 1:
			return land_move_state
	return null
