extends TextureRect

func _ready():
	Singleton.lose.connect(play)
	Singleton.win.connect(play)
	Singleton.drowning.connect(drowning)
	$AnimationPlayer.play("fade_to_normal")

func play():
	$AnimationPlayer.play("fade_to_black")

func drowning():
	$AnimationPlayer.play("drowning")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		Singleton.restart.emit()
