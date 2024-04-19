class_name OxygenLevel
extends Control

@onready
var lungs_label: Label = $LungsLabel
@onready
var tank_label: Label = $TankLabel

@export var lung_capacity: int = 5
@export var tank_capacity: int = 5

var lungs_left = lung_capacity

var tank_left = tank_capacity

var player: Player

var state_drowning : bool
var lung_threshold: int = 3
var overal_threshold : int = 5

const DEFAULT_COLOR = Color("171615")

func _ready():
	var p = get_parent()
	while not p is Player:
		p = p.get_parent()
	player = p
	lungs_label.set_text(str(snapped(lungs_left, 0.1)))
	tank_label.set_text(str(snapped(tank_left, 0.1)))

func _physics_process(delta):
	if not player.alive:
		return
	if lungs_left + tank_left <= 0:
		player.die()
	if player.in_water:
		lungs_left -= delta
		if lungs_left < 0:
			tank_left += lungs_left
			lungs_left = 0
			test_drowning()
	else:
		state_drowning = false
		Singleton.drowning.emit(state_drowning)
		if lungs_left < lung_capacity:
			lungs_left = lung_capacity
			var timer = get_tree().create_timer(0.15)
			timer.timeout.connect($gasp.play)

func test_drowning():
	if lungs_left >= lung_threshold:
		return
	if lungs_left + tank_left >= overal_threshold:
		return
	if state_drowning:
		return
	state_drowning = true
	Singleton.drowning.emit(state_drowning)
	
	

func _process(delta):
	if not player.alive:
		return
	if lungs_left <= 0:
		lungs_label.set_text("0")
		lungs_label.add_theme_color_override(\
			"font_color", Color.RED)
	else:
		lungs_label.set_text(str(snapped(lungs_left, 0.1)))
		lungs_label.add_theme_color_override(\
			"font_color", DEFAULT_COLOR)
	
	if tank_left <= 0:
		tank_label.set_text("0")
		tank_label.add_theme_color_override(\
			"font_color", Color.RED)
	else:
		tank_label.set_text(str(snapped(tank_left, 0.1)))
		tank_label.add_theme_color_override(\
			"font_color", DEFAULT_COLOR)

