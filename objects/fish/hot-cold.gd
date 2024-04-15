extends PointLight2D

# hot-cold render
var escapes = []
		
func _ready():
	var root = get_tree().root.get_node('LevelRoot')
	for i in root.get_node(^'World/Escapes').get_children():
		if 'Escape' in i.name:
			escapes.append(i)

func _process(delta):
	var min_dist = 999999
	for e in escapes:
		var dist = self.global_position.distance_to(e.global_position)
		min_dist = min(dist, min_dist)
	evaluate_hot_cold(min_dist)

func evaluate_hot_cold(dist):
	# when dist is < 50, e = 2
	# when dist is > 300, e < 1
	var e = 0
	var s = 0
	if dist < 50:
		e = 2
		s - 3
	elif dist <= 300:
		e = 2-1.1*(dist-50)/150
		s = 3-(2*(dist-50)/150)
	else:
		e = 0.9*(0.99**(dist-200))
		s = 1*(0.99**(dist-200))
	e = max(e, 0)
	s = max(s, 0)
	set_energy(e)
	set_texture_scale(s)
