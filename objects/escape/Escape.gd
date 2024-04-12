extends Area2D

var wind_up = 1
var wind_up_progress = 0

var player_arrived = false

var won_shown = false

func _physics_process(delta):
	if player_arrived:
		wind_up_progress += delta
	if wind_up_progress >= wind_up:
		if not won_shown:
			won_shown = true
			print_rich("[font_size=48][color=green]Victory![/color][/font_size]")

func _on_body_entered(body):
	if body is Player:
		player_arrived = true

func _on_body_exited(body):
	if body is Player:
		wind_up_progress = 0
		player_arrived = false
		won_shown = false
