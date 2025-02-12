extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimationPlayer")

func _physics_process(delta):
	# Apply gravity if not on the floor
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jumping
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY 
		anim.play("jump")  # Play jump animation

	# Get horizontal input direction
	var direction = Input.get_axis("ui_left", "ui_right")
	
	# Flip the sprite based on direction
	if direction == -1:
		get_node("Sprite2D2").flip_h = true
	elif direction == 1:
		get_node("Sprite2D2").flip_h = false

	# Handle movement and animations
	if direction != 0:
		velocity.x = direction * SPEED
		if is_on_floor():
			anim.play("running")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			anim.play("idle")

	# Move the character
	move_and_slide()

	# Ensure the jump animation is not interrupted by other animations
	if not is_on_floor() and anim.current_animation != "jump":
		anim.play("jump")
