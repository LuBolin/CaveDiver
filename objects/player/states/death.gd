extends State

func enter():
	super()
	parent.alive = false
	var timer = get_tree().create_timer(2)
	timer.timeout.connect(func(): Singleton.restart.emit())

func process_physics(delta: float):
	return null
