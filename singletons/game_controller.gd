extends Node

var player = preload("res://player/player.tscn")

var score = 0
var current_level_number: int
var current_scene_path: String

signal score_changed(new_value)

func on_get_coin():
	score += 1
	emit_signal("score_changed", score)


func on_next_level():
	var current_level_number = int(get_tree().current_scene.name.split("_")[1])
	get_tree().change_scene_to_file("res://levels/level_" + str(current_level_number + 1) + ".tscn")
	

func spawn_player_on_scene():
	var level_root = get_tree().get_nodes_in_group("level_root").front()
	var checkpoint = get_tree().get_nodes_in_group("checkpoint").front()
	var player_instance = player.instantiate()
	player_instance.position = checkpoint.position
	level_root.add_child(player_instance)
