extends Camera2D

@onready var tile_map: TileMap = $"../../World/TileMap"
@onready var player: Player = $"../../Player"

var max_zoom = 4
var zoom_step = 0.2

var bounds = null

func _ready():
	var used_rect: Rect2i = tile_map.get_used_rect()
	var tile_size: Vector2i = tile_map.get_tileset().get_tile_size()
	var tm_pos: Vector2 = tile_map.global_position
	
	bounds = Rect2(\
		tm_pos + Vector2(used_rect.position * tile_size),\
		used_rect.size * tile_size)
	
	set_limit(SIDE_LEFT, bounds.position.x)
	set_limit(SIDE_TOP, bounds.position.y)
	set_limit(SIDE_RIGHT, bounds.position.x + bounds.size.x)
	set_limit(SIDE_BOTTOM, bounds.position.y + bounds.size.y)
	
	toggle_zoom()

func move():
	global_position = player.global_position

func _process(delta):
	move()

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		match event.button_index:
			MOUSE_BUTTON_WHEEL_UP:
				adjust_zoom(1)
			MOUSE_BUTTON_WHEEL_DOWN:
				adjust_zoom(-1)

	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_RIGHT:
			toggle_zoom()

func toggle_zoom():
	if zoom == max_zoom * Vector2.ONE:
		zoom = 2 * Vector2.ONE
	else:
		zoom = max_zoom * Vector2.ONE

func adjust_zoom(direction):
	var proposed_zoom = zoom.x + zoom_step * direction
	if proposed_zoom > max_zoom:
		return
	var viewport_size = get_viewport_rect().size / proposed_zoom
	if viewport_size.x > bounds.size.x \
		or viewport_size.y > bounds.size.y:
		return
	zoom = Vector2(proposed_zoom, proposed_zoom)
