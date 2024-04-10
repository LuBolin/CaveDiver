extends State

@export
var land_fall_state: State
@export
var land_jump_state: State
@export
var land_idle_state: State
@export
var water_idle_state: State

func enter():
	super()
	parent.velocity.x = 0

func process_physics(delta):
	parent.velocity.y += gravity * delta
	
	var movement = Input.get_axis("move_left", "move_right") \
		* land_move_speed
	if movement != 0:
		parent.animations.flip_h = movement < 0
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if parent.in_water():
		return water_idle_state
	
	if parent.is_on_floor():
		if movement == 0:
			return land_idle_state
	else:
		return land_fall_state
	
	return null

func process_input(event):
	if Input.is_action_just_pressed("move_up") \
		and parent.is_on_floor():
			return land_jump_state
	return null
