class_name OxygenLevel
extends Control

@onready
var lungs_label: Label = $LungsLabel
@onready
var tank_label: Label = $TankLabel

@export var lung_capacity: int = 5
@export var tank_capacity: int = 20

var lungs_left = lung_capacity

var tank_left = tank_capacity

var player: Player

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
	if player.in_water:
		lungs_left -= delta
		if lungs_left < 0:
			tank_left += lungs_left
			lungs_left = 0
	else:
		if lungs_left < lung_capacity:
			lungs_left = lung_capacity

func _process(delta):
	if not player.alive:
		return
	if lungs_left < 0:
		lungs_label.set_text("No more breath!")
	else:
		lungs_label.set_text(str(snapped(lungs_left, 0.1)))
	
	if tank_left < 0:
		tank_label.set_text("Empty!")
	else:
		tank_label.set_text(str(snapped(tank_left, 0.1)))

