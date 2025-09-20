extends Node

var enemy_scene = preload("res://entities/enemies/enemy.tscn")

func _ready():
	
	#If the enemy ship touches the blue boundary, execute game over function.
	get_parent().get_node("BlueBoundary").connect("area_entered",_game_over)
	#Timer will decide when to spawn the enemy.
	#Since we don't need the timer to update with every frame, we won't put it under _process function.
	#creating a new object of the Timer class.
	var timer = Timer.new()
	add_child(timer) #Now we gotta add the timer to our scene ##since we are already in enemySpawner node, using add_child() will directly add it to this group. No need to get parents and stuff.
	
	timer.wait_time = 2 #kitni der mei trigger hoga baar baar -> 2 seconds
	
	
	timer.connect("timeout",_createEnemy) 
	timer.start()
	
	
func _game_over(body:Node):
	#if the body that touched the boundary is from "Enemy" class, then perform the following. **This is becuase we don't want anything to happen if the bullets touch the boundary**
	if body is Enemy:
		get_tree().set_pause(true) #pauses the whole screen if enemy touches the boundary


func _createEnemy():
	#initantiating the enemy_scene object
	var enemy = enemy_scene.instantiate()
	#Everytime an enemy spawns, it'll get added in the enemies node under the parent GameManager
	get_parent().get_node("Enemies").add_child(enemy)
