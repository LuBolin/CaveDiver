class_name FishAmmo
extends TextureRect

@onready var count_label: Label = $CountLabel
@onready var select_frame: TextureRect = $SelectFrame
@export var fish_scene: PackedScene
var count: int = 0

const DEFAULT_COLOR = Color("171615")

func _ready():
	update_label()

func set_selected(selected):
	select_frame.visible = selected

func push_fish():
	count += 1
	update_label()

func pop_fish():
	if count > 0:
		count -= 1
		update_label()
		return fish_scene
	update_label()
	return false

func update_label():
	count_label.set_text(str(count))
	var ls = LabelSettings.new()
	if count <= 0:
		
		count_label.add_theme_color_override(\
			"font_color", Color.RED)
	else:
		count_label.add_theme_color_override(\
			"font_color", DEFAULT_COLOR)

func has_ammo():
	return count > 0
