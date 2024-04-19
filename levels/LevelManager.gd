class_name LevelManager
extends Node2D

@onready var main_menu: PackedScene = preload("res://levels/MainMenu/MainMenu.tscn")
@onready var darkness: DirectionalLight2D = $Misc/Darkness
@onready var water_shader: TextureRect = $World/Water_Shader
@onready var level_label: Label = $CanvasLayer/LevelLabel
# Called when the node enters the scene tree for the first time.

var level_num_regex = RegEx.new()
var level_num: int

func _ready():
	var level_scene_file_path = get_tree().current_scene.scene_file_path
	# res://levels/Level X.tscn
	level_num_regex.compile("^res://levels/Level (\\d+)\\.tscn$")
	var result = level_num_regex.search(level_scene_file_path)
	if result: # should always be true
		level_num = int(result.get_string(1))
	level_label.set_text("Level " + str(level_num))
	
	Singleton.restart.connect(restart)
	Singleton.escape.connect(to_menu)
	Singleton.win.connect(win)
	darkness.visible = true

func restart():
	get_tree().reload_current_scene()

func to_menu():
	get_tree().change_scene_to_packed(main_menu)

func win():
	Singleton.levelsBeaten.append(level_num)
	Singleton.save_data()
	await get_tree().create_timer(2.5).timeout
	to_menu()
