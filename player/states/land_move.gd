extends State

@export
var land_fall_state: State
@export
var land_jump_state: State
@export
var land_idle_state: State
@export
var water_idle_state: State
@onready
var footstep: AudioStreamPlayer2D = $footstep

func enter():
	super()
	parent.velocity.x = 0
	footstep.play()

func exit():
	super()
	footstep.stop()

func process_physics(delta):
	parent.velocity.y += gravity * delta
	
	var movement = Input.get_axis("move_left", "move_right") \
		* land_move_speed
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if parent.in_water:
		return water_idle_state
	
	if parent.is_on_floor():
		if movement == 0:
			return land_idle_state
	else:
		return land_fall_state
	
	return null

func process_input(event):
	if Input.is_action_just_pressed("jump") \
		and parent.is_on_floor():
			return land_jump_state
	return null
