extends Node

var player = preload("res://player/player.tscn")

var score = 0
var current_level_number: int
var current_scene_path: String
var is_paused = false

signal score_changed(new_value)
signal game_over()
signal restart_game()
signal game_paused(is_paused)

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	

func on_get_coin():
	score += 1
	emit_signal("score_changed", score)


func _process(_delta):
	toggle_pause()

func on_next_level():
	get_tree().change_scene_to_file("res://levels/level_" + str(current_level_number + 1) + ".tscn")
	

func spawn_player_on_scene():
	var level_root = get_tree().get_nodes_in_group("level_root").front()
	var checkpoint = get_tree().get_nodes_in_group("checkpoint").front()
	var player_instance = player.instantiate()
	player_instance.position = checkpoint.position
	level_root.add_child(player_instance)


func on_game_over():
	get_tree().paused = true
	emit_signal("game_over")
	

func restart_level():
	get_tree().paused = false
	get_tree().reload_current_scene()
	emit_signal("restart_game")


func toggle_pause():
	if Input.is_action_just_pressed("Pause"):
		is_paused = !is_paused
		get_tree().paused = is_paused
		emit_signal("game_paused", is_paused)
	
