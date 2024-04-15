extends Area2D

var wind_up = 1
var wind_up_progress = 0

var player_arrived = false

func _physics_process(delta):
	if player_arrived:
		wind_up_progress += delta
	if wind_up_progress >= wind_up:
		Singleton.win.emit()

func _on_body_entered(body):
	if body is Player:
		player_arrived = true

func _on_body_exited(body):
	if body is Player:
		wind_up_progress = 0
		player_arrived = false
