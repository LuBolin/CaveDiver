extends Area2D

@onready var player: Player = $".."

var collect_state = false

func _input(event):
	if event is InputEventKey:
		if event.keycode == KEY_C:
			collect_state = event.is_pressed()
			print(collect_state)

func _on_body_entered(body):
	if not player.alive:
		return
	if body is Fish:
		if body.live and not collect_state:
			return
		#var scene = PackedScene.new()
		#scene.pack(body)
		body.pick_up()
		var fish_script = body.get_script()
		var fish_ammo_type: FishType.FishTypeEnum = \
			body.fish_type.fish_ammo_type
		player.pickup_fish(fish_ammo_type)
