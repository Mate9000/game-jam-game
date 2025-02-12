extends CharacterBody2D
var SPEED = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false
func _physics_process(delta):
	velocity.y += gravity * delta
	if chase == true:
		player = get_node("../../player/player01")
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = false
		else:
			get_node("AnimatedSprite2D").flip_h = true
		velocity.x = direction.x * SPEED
	move_and_slide()
func _on_player_detection_body_entered(body):
	if body.name == "player01":
		chase = true


func _on_player_detection_body_exited(body):
	if body.name == "player01":
		chase = false
