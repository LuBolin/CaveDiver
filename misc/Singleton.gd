extends Node
signal win
signal lose
signal restart
signal escape
signal drowning(drowning)

const SAVE_FILE_PATH = "user://saves/LevelsBeaten.dat"

var levelsBeaten = []

func _ready():
	var dir = DirAccess.open("user://")
	dir.make_dir("saves")

func save_data():
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	for level in levelsBeaten:
		file.store_16(level)

func load_data():
	if FileAccess.file_exists(SAVE_FILE_PATH):
		var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
		while not file.eof_reached():
			levelsBeaten.append(file.get_16())

func _input(event):
	if not (event is InputEventKey):
		return
	if not (event.is_pressed()):
		return
	match event.keycode:
		KEY_R:
			restart.emit()
		KEY_ESCAPE:
			escape.emit()
