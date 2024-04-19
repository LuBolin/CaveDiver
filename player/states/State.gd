class_name State
extends Node

@export
var animation_name: String
@export
var land_move_speed: float = 80
var water_move_speed: float = 90
var water_float_speed: float = 80
var water_sink_speed: float = 200
var terminal_fall_speed: float = 150
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

var water_idle_fall_speed = 40

var parent: Player

func enter():
	#parent.animations.play(animation_name)
	parent.animations.play(self.name)
	parent.state_label.set_text(self.name)

func exit():
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	return null

func process_frame(delta: float) -> State:
	return null
