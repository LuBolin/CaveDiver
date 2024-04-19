extends Area2D

@onready var player: Player = $".."

var collect_state = false

func _unhandled_input(event):
	if event is InputEventKey:
		if event.keycode == KEY_C:
			collect_state = event.is_pressed()
			if collect_state:
				force_check()

func force_check():
	if not player.alive:
		return
	var bodies = get_overlapping_bodies()
	for b in bodies:
		_on_body_entered(b)

func _on_body_entered(body):
	if not player.alive:
		return
	if not collect_state:
		return
	if body is Fish:
		if not body.left_player:
			return
		#var scene = PackedScene.new()
		#scene.pack(body)
		body.pick_up()
		var fish_script = body.get_script()
		var fish_ammo_type: FishType.FishTypeEnum = \
			body.fish_type.fish_ammo_type
		player.pickup_fish(fish_ammo_type)
		$pickup.play()


func _on_body_exited(body):
	if body is Fish:
		body.left_player = true
