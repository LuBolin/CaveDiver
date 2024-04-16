extends Node2D

@export
var starting_state: State

@onready
var player: Player = $".."

var current_state: State

func init(parent: Player):
	for child in get_children():
		if not (child is State):
			continue
		child.parent = parent
	change_state(starting_state)

func change_state(new_state: State):
	if current_state:
		current_state.exit()
	current_state = new_state
	
	# checks for buttons that are held down
	var newer_state = current_state.enter()
	if newer_state:
		change_state(newer_state)

func process_input(event):
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)

func process_physics(delta):
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_frame(delta):
	var movement = Input.get_axis("move_left", "move_right")
	if movement != 0:
		player.animations.flip_h = movement < 0
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)
