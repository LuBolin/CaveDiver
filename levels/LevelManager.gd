extends Node2D

@onready var main_menu: PackedScene = preload("res://levels/MainMenu/MainMenu.tscn")
@onready var darkness: DirectionalLight2D = $Misc/Darkness
# Called when the node enters the scene tree for the first time.
func _ready():
	Singleton.restart.connect(restart)
	Singleton.escape.connect(to_menu)
	darkness.visible = true

func restart():
	get_tree().reload_current_scene()

func to_menu():
	get_tree().change_scene_to_packed(main_menu)
