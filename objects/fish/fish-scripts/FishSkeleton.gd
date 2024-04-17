class_name FishSkeleton
extends Node2D

#@export var sprite : Sprite2D
@export var anim_sprite: AnimatedSprite2D
@export var fish_trail : FishTrail
@export var oxygen_light: PointLight2D

func install(fish : Fish, fish_frames : SpriteFrames, fish_trail_gradient : Gradient):
	anim_sprite.set_sprite_frames(fish_frames)
	anim_sprite.play()
	fish_trail.install(fish, fish_trail_gradient)

func update(sprite_angle, delta):
	anim_sprite.update(sprite_angle)
	fish_trail.update(delta)

func die():
	anim_sprite.die()
	fish_trail.die()
