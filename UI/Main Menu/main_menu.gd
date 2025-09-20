extends Control


func _ready():
	pass

func _process(delta:float):
	pass



func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://game_manager.tscn")


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
