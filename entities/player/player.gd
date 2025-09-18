extends Node2D #extends is used to show inheritance in godot

# declaring variables
# var a = 34;
# var b = "text"
# var c = true
var direction:int = 0
var directionHeight:int = 0
var speed:int = 300
var screenSize:Vector2 #Vector2 is a pair of numbers (x,y), we can store a position (x,y), height and width (h,w), and movement offsets, etc.
var bullet_scene = preload("res://entities/bullets/bullet.tscn")
# := is used to know the type of variable from its value in real time
var shoot_time:= 1.0
var shoot_counter= 0
var firingRate = 5 

var max_energy:= 100
var Energy = max_energy
var fireCooldown:= 3
var recharging:= false
var cooldown_timer:= 0.0 
var energy_bar
var idle_time:float =0.0
#initialzer function, called when the scene is loaded for the first time in the tree
func _ready():
	screenSize = get_viewport().get_visible_rect().size
	energy_bar = get_parent().get_node("Energy_bar/ProgressBar")

# main function, here "delta" is the time elapsed since the previous frame
func _process(delta):
	#If the energy bar is recharging...
	if recharging:
		cooldown_timer-=delta
		if cooldown_timer <= 0:
			Energy = max_energy
			recharging = false
	else:
		#Shoot logic
		shoot_counter+=firingRate*delta
		if Input.is_action_pressed("shoot") and shoot_counter > shoot_time:
			if Energy > 0:
				shoot_counter = 0
				Energy = min(Energy-400*delta,max_energy)
				energy_bar.value = Energy
				
				#created an instance of the bullet_scene object
				var bullet_instance = bullet_scene.instantiate()
				bullet_instance.position.x = position.x #same position of the x coordinate as of the player's ship
				bullet_instance.position.y = position.y-30 # up by 10px in y coordinate, as bullet will appear a little above the player's ship
				get_parent().get_node("Bullets").add_child(bullet_instance)
				if Energy <= 0:
					Energy = 0
					recharging = true
					cooldown_timer = fireCooldown
		
		#Idle player energy recharge
		if not Input.is_action_pressed("shoot"):
			idle_time+=delta
			if idle_time>=1.0:
				Energy = min(Energy + 10*delta,max_energy)
				energy_bar.value = Energy
		else:
			idle_time = 0.0
	
	
	if Input.is_action_pressed("move_left"):
		direction = -1
		rotation = deg_to_rad(-15.5) #tilt left
	elif Input.is_action_pressed("move_right"):
		direction = 1
		rotation = deg_to_rad(15.5) #tilt right 
	else:
		direction = 0
		rotation = 0
		
	if Input.is_action_pressed("move_up"):
		#in godot the 'y' coordinate moves downward in positive side, so to go UP you have to basically go to the negative values, and vice versa for goin down.
		directionHeight = -1
	elif Input.is_action_pressed("move_down"):
		directionHeight = 1
	else:
		directionHeight = 0
	
	position.x += direction*speed*delta
	position.y += directionHeight*speed*delta
	
	#making it so that the ship doesn't leave the screen
	position.x = clamp(position.x,30,screenSize.x-30) #this will keep the ship 30px from left, and 30px from right within the screen
	position.y = clamp(position.y,30,screenSize.y-30) #this will keep the ship 30px from top, and 30px from bottom within the screen
