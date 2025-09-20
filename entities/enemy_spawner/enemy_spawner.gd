extends Node

var enemy_scene = preload("res://entities/enemies/enemy.tscn")

func _ready():
	
	get_parent().get_node("BlueBoundary").connect("area_entered",_game_over)
	var timer = Timer.new()
	add_child(timer) 
	
	timer.wait_time = 2
	
	
	timer.connect("timeout",_createEnemy) 
	timer.start()
	
	
func _game_over(body:Node):
	if body is Enemy:
		get_tree().set_pause(true) 


func _createEnemy():
	var enemy = enemy_scene.instantiate()
	get_parent().get_node("Enemies").add_child(enemy)
