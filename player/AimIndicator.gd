extends Node2D

@onready var player: Player = $".."
@onready var arrow: Sprite2D = $Arrow

var aiming = false

func _ready():
	aiming = false
	arrow.visible = false

func _process(delta):
	if not player.alive:
		self.visible = false

func _input(event):
	if not event is InputEventMouse:
		return
	var target = get_global_mouse_position()
	self.look_at(target)
	#if event is InputEventMouseMotion and aiming:
	
	if event is InputEventMouseButton \
		and event.button_index == MOUSE_BUTTON_LEFT:
			if not player.has_ammo():
				return
			aiming = event.is_pressed()
			arrow.visible = aiming
			if not aiming: # release
				var direction = target - self.global_position
				player.launch_fish(direction)
			else:
				self.look_at(target)
