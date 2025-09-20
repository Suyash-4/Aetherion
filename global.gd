extends Node

var high_score: int = 0
var current_score: int = 0

const SAVE_PATH := "user://save.cfg"

func _ready() -> void:
	load_high_score()

func set_high_score(value: int) -> void:
	high_score = value
	save_high_score()

func save_high_score() -> void:
	var config := ConfigFile.new()
	config.set_value("scores", "high_score", high_score)
	var err := config.save(SAVE_PATH)
	if err != OK:
		push_error("Failed to save high score: %s" % str(err))

func load_high_score() -> void:
	var config := ConfigFile.new()
	var err := config.load(SAVE_PATH)
	if err == OK:
		high_score = config.get_value("scores", "high_score", 0)
	else:
		high_score = 0
