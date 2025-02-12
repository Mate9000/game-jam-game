extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false
func _physics_process(delta):
	velocity.y += gravity * delta
	player = get_node("../../player/player01")
	var direction = (player.position - self.position).normalized()
	if direction.x > 0:
		if chase == true:
			print ("Chase Right")
	else:
		print("Left")

	move_and_slide()
func _on_player_detection_body_entered(body):
	if body.name == "player01":
		chase = true


func _on_player_detection_body_exited(body: Node2D) -> void:
	if body.name == "player01":
		chase = false
