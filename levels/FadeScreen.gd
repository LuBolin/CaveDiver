extends TextureRect

var state : String = ""

func _ready():
	Singleton.lose.connect(die)
	Singleton.win.connect(next)
	Singleton.drowning.connect(drowning)
	$AnimationPlayer.play("fade_to_normal")

func die():
	$AnimationPlayer.play("fade_to_black")
	state = "die"

func next():
	$AnimationPlayer.play("fade_to_black")
	state = "win"

func drowning():
	$AnimationPlayer.play("drowning")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		match(state):
			"die":
				Singleton.restart.emit()
			"win":
				pass
		state = ""
