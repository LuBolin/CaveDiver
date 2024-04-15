extends Node2D

@onready var buttonsGrid = $ControlsGroup/LevelButtons
@onready var lvl_button_template = \
	preload("res://levels/MainMenu/level_button.tscn")

const lvl_scenes_dir = "res://levels"
# "Level X.tscn"
var lvl_scene_name_regex = RegEx.new()

var levels = []

func _ready():
	lvl_scene_name_regex.compile("^Level (\\d+)\\.tscn$")
	init_levels()
	for l in levels:
		var lvl_num = l[0]
		var lvl_scene = l[1]
		var lvl_button = lvl_button_template.instantiate()
		buttonsGrid.add_child(lvl_button)
		lvl_button.set_text(str(lvl_num))
		lvl_button.pressed.connect(func x(): gotoLevel(lvl_scene))
	self.renderBeaten()

func init_levels():
	var dir = DirAccess.open(lvl_scenes_dir)
	for f in dir.get_files():
		if lvl_scene_name_regex.search(f):
			var lvl_scene = load(lvl_scenes_dir + "//" + f)
			var lvl_digits = f.length()-11 #"Level ".length() - ".tscn".length()
			var lvl_num = int(f.substr(6,lvl_digits))
			levels.append([lvl_num, lvl_scene])

func gotoLevel(lvl_scene):
	get_tree().change_scene_to_packed(lvl_scene)

func renderBeaten():
	Singleton.load_data()
	var levelButtons = buttonsGrid.get_children()
	for index in levelButtons.size():
		var button = levelButtons[index]
		# red_tick
		var cleared = Singleton.levelsBeaten \
			and (index+1) in Singleton.levelsBeaten
		var cleared_checkmark = button.get_node("Cleared")
		if cleared_checkmark:
			button.get_child(0).visible = cleared

func _on_clear_beaten_button_pressed():
	Singleton.levelsBeaten = []
	Singleton.save_data()
	renderBeaten()
