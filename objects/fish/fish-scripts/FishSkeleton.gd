class_name FishSkeleton
extends Node2D


@export var sprite : Sprite2D
@export var fish_trail : FishTrail
@export var oxygen_light: PointLight2D

func install(fish : Fish, fish_texture : Texture2D):
	sprite.set_texture(fish_texture)
	fish_trail.install(fish)

func update(sprite_angle, delta):
	sprite.update(sprite_angle)
	fish_trail.update(delta)

func die():
	fish_trail.die()
