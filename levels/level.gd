extends Node

@onready var game_controller = GameController

var player = preload("res://player/player.tscn")

func _ready():
		var current_level_number = int(get_tree().current_scene.name.split("_")[1])
		var current_scene_path = "res://levels/level_" + str(current_level_number) + ".tscn"
		game_controller.current_level_number = current_level_number
		game_controller.current_scene_path = current_scene_path
		game_controller.spawn_player_on_scene()
		
