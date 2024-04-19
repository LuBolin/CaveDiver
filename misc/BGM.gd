extends Node

func _ready():
	tree_entered.connect(scene_changed)

func scene_changed():
	print("Test")
