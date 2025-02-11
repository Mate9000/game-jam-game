extends CharacterBody2D

# Variables for enemy behavior
var detection_range = 200  # Distance within which the enemy will start moving towards the player
var speed = 100  # Speed at which the enemy moves towards the player
var patrol_speed = 50  # Speed at which the enemy patrols
var patrol_points = []  # Array to hold patrol points
var current_patrol_index = 0  # Index of the current patrol point

@onready var player = get_node("/root/Main/Player")  # Adjust the path to your player node

func _ready() -> void:
	# Initialize patrol points
	patrol_points.append(Vector2(100, 100))  # First patrol point
	patrol_points.append(Vector2(400, 100))  # Second patrol point

func _physics_process(delta: float) -> void:
	if player and position.distance_to(player.position) < detection_range:
		move_towards_player()
	else:
		patrol()

func patrol() -> void:
	var target_point = patrol_points[current_patrol_index]
	var direction = (target_point - position).normalized()
	
	# Move the enemy towards the patrol point
	var velocity = direction * patrol_speed
	move_and_slide()

	# Check if the enemy has reached the patrol point
	if position.distance_to(target_point) < 10:  # Adjust the threshold as needed
		current_patrol_index = (current_patrol_index + 1) % patrol_points.size()  # Cycle through patrol points

func move_towards_player() -> void:
	var direction = (player.position - position).normalized()
	
	# Move the enemy towards the player
	var velocity = direction * speed
	move_and_slide()
