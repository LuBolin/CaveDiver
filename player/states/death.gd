extends State

func enter():
	super()
	parent.alive = false
	$death.play()
	parent.animations.animation_finished.connect(die)

func die():
	Singleton.restart.emit()
