class_name Player
extends CharacterBody2D

@onready
var animations = $Renderer/AnimatedSprite
@onready
var state_machine = $StateMachine
@onready
var state_label = $StateLabel

@onready
var oxygen_buffer_label = $BufferLabel
@onready
var oxygen_tank_label = $TankLabel


var fish_scene: PackedScene = preload("res://objects/fish/sinusoidalfish.tscn")


var waters_area: Area2D

const oxygen_buffer = 5
var oxygen_buffer_left = oxygen_buffer
const oxygen_tank = 20
var oxygen_tank_left = oxygen_tank


func _ready():
	waters_area = get_node(^"../Waters_Area")
	state_machine.init(self)

func _unhandled_input(event):
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				var fish = fish_scene.instantiate()
				get_parent().add_child(fish)
				var mouse_pos = get_global_mouse_position()
				fish.global_position = mouse_pos
				var direction = mouse_pos - self.global_position
				fish.launch(direction)
	state_machine.process_input(event)

func _physics_process(delta):
	if in_water():
		oxygen_buffer_left -= delta
		if oxygen_buffer_left < 0:
			oxygen_tank_left += oxygen_buffer_left
			oxygen_buffer_left = 0
	state_machine.process_physics(delta)

func _process(delta):
	if oxygen_buffer_left < 0:
		oxygen_buffer_label.set_text("Empty!")
	else:
		oxygen_buffer_label.set_text(str(snapped(oxygen_buffer_left, 0.1)))
	
	if oxygen_tank_left < 0:
		oxygen_tank_label.set_text("Empty!")
	else:
		oxygen_tank_label.set_text(str(snapped(oxygen_tank_left, 0.1)))
	state_machine.process_frame(delta)

func in_water():
	return self in waters_area.get_overlapping_bodies()
	return global_position.x < 0
