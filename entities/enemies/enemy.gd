class_name Enemy #So that we can use this multiple times, in different files as well!
extends Area2D

var speed = 80
var points_for_kill = 10

func _ready():
	randomize()
	#random enemy spawn location from 30px margin on X-axis on both sides (30,500-30), and 0px margin on Y-axis since enemy will be coming from top, as we've set that margin globally for the game
	position = Vector2(randi_range(30,470),0)
	
func _process(delta):
	position.y+=speed*delta


#jo bhi area enemy ke area mei enter kiya hoga vo mil jaayega
func _on_area_entered(area: Area2D):
	if area.name=="BulletArea":
		area.get_parent().queue_free() 
		#Jo area milega, vo bullet ka hoga, so we get its parent i.e. the bullet node, and we delete (queue_free) it.
		queue_free()
		Global.current_score+=points_for_kill
