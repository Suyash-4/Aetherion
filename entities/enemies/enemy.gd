class_name Enemy 
extends Area2D

var speed = 80
var points_for_kill = 10

func _ready():
	randomize()
	position = Vector2(randi_range(30,470),0)
	
func _process(delta):
	position.y+=speed*delta


func _on_area_entered(area: Area2D):
	if area.name=="BulletArea":
		area.get_parent().queue_free() 
		queue_free()
		Global.current_score+=points_for_kill
