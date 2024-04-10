extends CharacterBody2D

var fish_scene: PackedScene = preload("res://objects/fish/basicfish.tscn")

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _input(event):
	if event is InputEventKey:
		return
	if (event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT):
		var mouse_pos = get_global_mouse_position()
		var fish = fish_scene.instantiate()
		get_parent().add_child(fish)
		fish.global_position = mouse_pos
		var direction = mouse_pos - self.global_position
		fish.launch(direction)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
