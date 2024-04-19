extends State

signal died

func enter():
	super()
	parent.alive = false
	$death.play()
	#parent.animations.animation_finished.connect(die)
	Singleton.lose.emit()

func die():
	Singleton.restart.emit()
