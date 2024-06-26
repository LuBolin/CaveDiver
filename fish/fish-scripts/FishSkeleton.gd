class_name FishSkeleton
extends Node2D

#@export var sprite : Sprite2D
@export var anim_sprite: AnimatedSprite2D
@export var fish_trail : FishTrail
@export var oxygen_light: OxygenLight

@onready var death: AudioStreamPlayer2D = $death
@onready var swim: AudioStreamPlayer2D = $swim

func play_swim(play):
	if play:
		if not swim.is_playing():
			swim.play()
	else:
		if swim.is_playing():
			swim.stop()

func install(fish : Fish, fish_frames : SpriteFrames, fish_trail_gradient : Gradient, b : float):
	anim_sprite.set_sprite_frames(fish_frames)
	anim_sprite.play()
	fish_trail.install(fish, fish_trail_gradient)
	oxygen_light.energy_addition = b

func update(sprite_angle, delta):
	anim_sprite.update(sprite_angle)
	fish_trail.update(delta)

func die():
	swim.stop()
	death.play()
	anim_sprite.die()
	fish_trail.die()

