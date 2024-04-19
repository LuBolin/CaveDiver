extends Area2D

@export var water_version: bool = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var victory: AudioStreamPlayer2D = $victory

var wind_up = 0.1
var wind_up_progress = 0

var player_arrived = false

func _ready():
	if water_version:
		animated_sprite.play("water")
	else:
		animated_sprite.play("land")

func _physics_process(delta):
	if wind_up_progress >= wind_up:
		return
	if player_arrived:
		wind_up_progress += delta
	if wind_up_progress >= wind_up:
		$victory.play()
		Singleton.win.emit()

func _on_body_entered(body):
	if body is Player:
		player_arrived = true

func _on_body_exited(body):
	if body is Player:
		wind_up_progress = 0
		player_arrived = false
