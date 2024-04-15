extends Area2D

func _ready():
	self.body_entered.connect(_enter_water)
	self.body_exited.connect(_exit_water)

func _enter_water(body):
	if body.get('in_water') is bool: # has_property()
		body.in_water = true

func _exit_water(body):
	if body.get('in_water') is bool: # has_property()
		body.in_water = false
