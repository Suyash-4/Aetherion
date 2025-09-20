extends Node2D


func _process(delta):
	update_score()
	
func update_score():
	
	if Global.current_score > Global.high_score:
		Global.set_high_score(Global.current_score)
	
