extends Node2D

var bullet_speed := 500



func _process(delta):
	# Move the bullet upward
	position.y -= bullet_speed * delta
	
	# If bullet goes above the screen (margin of 10px), delete it
	if position.y < -30:
		queue_free()  # removes the bullet node
	
