extends Node2D

@export
var starting_state: State

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
	current_state.enter()

func process_input(event):
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)

func process_physics(delta):
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_frame(delta):
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)