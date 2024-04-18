class_name OxygenLight
extends PointLight2D

# hot-cold render
var air_pockets = []
var energy_multiplier : float = 3
		
func _ready():
	var root = get_tree().root.get_node('LevelRoot')
	await Engine.get_main_loop().process_frame
	var air_pockets_area = root.get_node(^'World/AirPockets')
	for i in air_pockets_area.get_children():
		if not i is CollisionShape2D:
			return
		var i_rect = i.get_shape().get_rect()
		var i_pos = i.global_position
		var absolute_rect = Rect2(i_pos + i_rect.position, i_rect.size)
		air_pockets.append(absolute_rect)

func _process(delta):
	var min_dist = 999999
	for ap_rect2 in air_pockets:
		var dist = calculate_dist(ap_rect2)
		min_dist = min(dist, min_dist)
	evaluate_hot_cold(min_dist)

func calculate_dist(rect: Rect2) -> float:
	var own_pos = self.global_position

	# Rect2: top_left, size
	var closest_x = max(rect.position.x, \
		min(own_pos.x, rect.position.x + rect.size.x))
	var closest_y = max(rect.position.y, \
		min(own_pos.y, rect.position.y + rect.size.y))
	
	var distance = (Vector2(closest_x, closest_y) - own_pos).length()
	return distance

func evaluate_hot_cold(dist):
	# when dist is < 50, e = 2
	# when dist is > 300, e < 1
	var e = 0
	var s = 0
	if dist < 50:
		e = 2
		s = 3
	elif dist <= 300:
		e = 2-1.1*(dist-50)/150
		s = 3-(2*(dist-50)/150)
	else:
		e = 0.9*(0.99**(dist-200))
		s = 1*(0.99**(dist-200))
	e = max(e, 0)
	s = max(s, 0)
	e = e/6.0
	s = s/6.0
	set_energy(e * energy_multiplier)
	set_texture_scale(s * energy_multiplier)
