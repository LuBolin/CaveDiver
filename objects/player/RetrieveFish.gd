extends Area2D

@onready var player: Player = $".."

func _on_body_entered(body):
	if not player.alive:
		return
	if body is Fish:
		if body.live:
			return
		#var scene = PackedScene.new()
		#scene.pack(body)
		body.pick_up()
		var fish_script = body.get_script()
		var fish_ammo_type: FishType.FishTypeEnum = \
			body.fish_type.fish_ammo_type
		player.pickup_fish(fish_ammo_type)
