extends Node

@onready var game_controller = GameController
@onready var player_state = PlayerState

var save_path = "user://game_save.tres"

func save_data():
	var saved_game_data: SavedGameData = SavedGameData.new()
	
	saved_game_data.score = game_controller.score
	saved_game_data.current_level_path = game_controller.current_scene_path
	saved_game_data.player_health = player_state.health
	
	print(saved_game_data)
	ResourceSaver.save(saved_game_data, save_path)
	

func load_data():
	var saved_game_data: SavedGameData = load(save_path) as SavedGameData
	
	print(saved_game_data.current_level_path)
	print(saved_game_data.score)
	print(saved_game_data.player_health)
	get_tree().change_scene_to_file(saved_game_data.current_level_path)
	game_controller.score = saved_game_data.score
	player_state.health = saved_game_data.player_health
	
