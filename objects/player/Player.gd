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

@onready
var ammo_pouch: AmmoPouch = $CanvasLayer/AmmoPouch

var fish_scene: PackedScene = preload("res://objects/fish/jetfish.tscn")

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
				var fish_resource = ammo_pouch.pop_fish()
				if fish_resource:
					var fish = fish_resource.instantiate()
					get_parent().add_child(fish)
					var mouse_pos = get_global_mouse_position()
					fish.global_position = mouse_pos
					var direction = mouse_pos - self.global_position
					fish.launch(direction)
	state_machine.process_input(event)

func _physics_process(delta):
	if submerged():
		oxygen_buffer_left -= delta
		if oxygen_buffer_left < 0:
			oxygen_tank_left += oxygen_buffer_left
			oxygen_buffer_left = 0
	else:
		oxygen_buffer_left = oxygen_buffer

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

func submerged():
	var submerged = waters_area.overlaps_area($Head)
	return submerged

func in_water():
	var in_water = waters_area.overlaps_body(self)
	return in_water
