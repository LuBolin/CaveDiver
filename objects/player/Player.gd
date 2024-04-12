class_name Player
extends CharacterBody2D

@onready
var animations = $Renderer/AnimatedSprite
@onready
var state_machine = $StateMachine
@onready
var state_label = $StateLabel

@onready
var ammo_pouch: AmmoPouch = $CanvasLayer/AmmoPouch
@onready
var oxygen_level: OxygenLevel = $CanvasLayer/OxygenLevel

var fish_scene: PackedScene = preload("res://objects/fish/jetfish.tscn")

var waters_area: Area2D


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
	state_machine.process_physics(delta)

func _process(delta):
	state_machine.process_frame(delta)

func submerged():
	var submerged = waters_area.overlaps_area($Head)
	return submerged

func in_water():
	var in_water = waters_area.overlaps_body(self)
	return in_water
