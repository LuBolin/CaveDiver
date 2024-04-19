class_name AmmoPouch
extends Control

@onready var player: Player = $"../.."
@onready var launch: AudioStreamPlayer2D = $launch
var current_index: int = 0
var my_fishes = []

func _ready():
	for f in get_children():
		if f is FishAmmo:
			my_fishes.append(f)
	for i in player.initial_fishes:
		for j in range(i):
			my_fishes[i].push_fish()
	scroll(0)

func push_fish(fish_type_enum: FishType.FishTypeEnum):
	my_fishes[fish_type_enum].push_fish()

func pop_fish():
	var f = my_fishes[current_index]
	var fish_resource = f.pop_fish()
	if not fish_resource:
		return
	launch.play()
	return fish_resource

func has_ammo():
	return my_fishes[current_index].has_ammo()

func scroll(direction: int):
	var new_index = (current_index + direction) % my_fishes.size()
	my_fishes[current_index].set_selected(false)
	current_index = new_index
	my_fishes[current_index].set_selected(true)

func scroll_to(target: int):
	my_fishes[current_index].set_selected(false)
	current_index = target
	my_fishes[current_index].set_selected(true)

func _input(event):
	#if event is InputEventMouseButton and event.is_pressed():
		#match event.button_index:
			#MOUSE_BUTTON_WHEEL_UP:
				#scroll(-1)
			#MOUSE_BUTTON_WHEEL_DOWN:
				#scroll(1)
	if event is InputEventKey and event.is_pressed():
		match event.keycode:
			KEY_1:
				scroll_to(FishType.FishTypeEnum.Basic)
			KEY_2:
				scroll_to(FishType.FishTypeEnum.Sine)
			KEY_3:
				scroll_to(FishType.FishTypeEnum.Jet)
			KEY_4:
				scroll_to(FishType.FishTypeEnum.Glow)
		if Input.is_key_pressed(KEY_SHIFT):
			match event.keycode:
				KEY_1:
					push_fish(FishType.FishTypeEnum.Basic)
				KEY_2:
					push_fish(FishType.FishTypeEnum.Sine)
				KEY_3:
					push_fish(FishType.FishTypeEnum.Jet)
				KEY_3:
					push_fish(FishType.FishTypeEnum.Glow)
