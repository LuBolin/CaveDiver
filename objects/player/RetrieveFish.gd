extends Area2D

@onready var player: Player = $".."

func _on_body_entered(body):
	if body is Fish:
		if body.live:
			return
		var scene = PackedScene.new()
		scene.pack(body)
		player.pickup_fish(scene)
		body.pick_up()
