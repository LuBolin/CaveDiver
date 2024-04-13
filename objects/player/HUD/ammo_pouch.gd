class_name AmmoPouch
extends Control

@onready var scroll_container = $SmoothScrollContainer
@onready var vbox_list = $SmoothScrollContainer/VBoxContainer

var fish_ammo_dummy: PackedScene = preload('res://objects/player/HUD/fish_ammo.tscn')
var current_index: int = 0

@export var initial_fishes: Array[PackedScene] = []

# hiding of scroll-bar is achieved in "Theme"

func _ready():
	for f in initial_fishes:
		push_fish(f)

func push_fish(fish_resource: PackedScene):
	var instance = fish_resource.instantiate()
	var fish_type = instance.name.to_lower()
	var texture = instance.fish_texture
	instance.queue_free()
	
	# potentially retrieve texture by fish_type by file_name
	var new_fish = fish_ammo_dummy.instantiate()
	vbox_list.add_child(new_fish)
	new_fish.set_texture(texture)
	new_fish.set_meta("fish_type", fish_type)
	new_fish.set_meta("fish_resource", fish_resource)
	var fish_count = vbox_list.get_child_count()
	if fish_count == 1:
		current_index = 0
		new_fish.get_node("SelectFrame").set_visible(true)
	elif fish_count == current_index+2 : #+1 before pushing the new fish
		scroll(1)

func pop_fish():
	var fishes = vbox_list.get_children()
	if fishes.size() == 0:
		return null
	var popping = fishes[current_index]
	
	var fish_type = popping.get_meta("fish_type")
	var fish_resource = popping.get_meta("fish_resource")
	
	# reparent first, queue_free is delayed
	# but we need children to be accurate
	# for the sake of updating focus
	popping.reparent(get_parent())
	popping.queue_free()
	if current_index > 0:
		current_index -= 1
	scroll(0)
	return fish_resource

func scroll(direction: int):
	var fishes = vbox_list.get_children()
	var new_index = current_index + direction
	if new_index < 0 or new_index >= fishes.size():
		return
	var old_fish = fishes[current_index]
	old_fish.get_node("SelectFrame").set_visible(false)
	current_index = new_index
	var new_fish = fishes[current_index]
	new_fish.get_node("SelectFrame").set_visible(true)
	new_fish.grab_focus.call_deferred()

var basic_fish: PackedScene = preload("res://objects/fish/basicfish.tscn")
var sine_fish: PackedScene = preload("res://objects/fish/sinusoidalfish.tscn")
var jet_fish: PackedScene = preload("res://objects/fish/jetfish.tscn")
func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		match event.button_index:
			MOUSE_BUTTON_WHEEL_UP:
				scroll(-1)
			MOUSE_BUTTON_WHEEL_DOWN:
				scroll(1)
	elif event is InputEventKey and event.is_pressed():
		match event.keycode:
			KEY_1:
				push_fish(basic_fish)
			KEY_2:
				push_fish(sine_fish)
			KEY_3:
				push_fish(jet_fish)
