class_name Player
extends CharacterBody2D

@onready
var animations = $Renderer/MainAnimator
@onready
var state_machine = $StateMachine
@onready
var state_label = $StateLabel
@onready
var splash: AudioStreamPlayer2D = $StateMachine/splash

@onready
var ammo_pouch: AmmoPouch = $CanvasLayer/AmmoPouch
@onready
var oxygen_level: OxygenLevel = $CanvasLayer/OxygenLevel

@onready
var drip_animator: AnimatedSprite2D = $Renderer/DripWater


var alive: bool = true
var in_water: bool = false :
	set(value):
		if not value == in_water:
			in_water = value
			if not is_ready:
				return
			splash.play(1.3)

var is_ready = false

func _ready():
	is_ready = true
	var root_node = get_tree().root.get_node("LevelRoot")
	alive = true
	state_machine.init(self)

func _unhandled_input(event):
	if not alive:
		return
	state_machine.process_input(event)

func _physics_process(delta):
	if not alive:
		return
	state_machine.process_physics(delta)

func _process(delta):
	if not alive:
		return
	state_machine.process_frame(delta)

func launch_fish(direction):
	var fish_resource = ammo_pouch.pop_fish()
	if fish_resource:
		var fish = fish_resource.instantiate()
		get_parent().add_child(fish)
		fish.global_position = self.global_position
		fish.launch(direction)

func has_ammo():
	return ammo_pouch.has_ammo()

func pickup_fish(fish_type_enum: FishType.FishTypeEnum):
	ammo_pouch.push_fish(fish_type_enum)

@onready var death_state: State = $StateMachine/death
func die():
	state_machine.change_state(death_state)
