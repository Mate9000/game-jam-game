extends CharacterBody2D

const SPEED = 220.0
const JUMP_VELOCITY = -500.0

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D2

# State variables
var is_jumping = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		ap.play("jump")  # Play jump animation
		is_jumping = true  # Set jumping state

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		sprite.flip_h = (direction == -1)  # Flip sprite based on direction
		
		# Play running animation only if on the floor
		if is_on_floor() and not is_jumping:
			ap.play("running")  # Play running animation
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor() and not is_jumping:
			ap.play("idle")  # Play idle animation when not moving

	# Reset jumping state when landing
	if is_on_floor():
		is_jumping = false  # Reset jumping state

	# Move the character
	move_and_slide()

	# Optional: Print the velocity for debugging
	print(velocity)
