extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	self.body_entered.connect(_enter_water)
	self.body_exited.connect(_exit_water)


func _enter_water(body):
	if body.has_method('water_transition'):
		body.water_transition(true)

func _exit_water(body):
	if body.has_method('water_transition'):
		body.water_transition(false)
