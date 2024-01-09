extends CanvasLayer

var no_hearth_texture = preload("res://assets/hud_elements/no_hearts_hud.png")

@onready var game_controller = GameController
@onready var player_state = PlayerState
@onready var save_and_load = SaveAndLoad
@onready var label = $MarginContainer/MainUI/VBoxContainer/HBoxContainer/ScoreLabel
@onready var hearth_container = $MarginContainer/MainUI/VBoxContainer/HearthContainer
@onready var game_over_panel = $GameOverPanel
@onready var game_paused_panel = $PausePanel

var max_health = 5

func _ready():
	on_show_hearths()
	on_score_changed(game_controller.score)
	game_controller.connect("score_changed", on_score_changed)
	game_controller.connect("game_over", on_game_over)
	game_controller.connect("game_paused", on_game_paused)
	player_state.connect("health_changed", on_show_hearths)
	

func on_show_hearths():
	clear_hearths_container()
	var health = player_state.health
	var hearth_ui = preload("res://gui/hearth_ui.tscn")
	
	
	for i in range(max_health):
		var hearth_ui_instance = hearth_ui.instantiate()
		if i + 1 > health:
			hearth_ui_instance.texture = no_hearth_texture
		
		hearth_container.add_child(hearth_ui_instance)
		

func clear_hearths_container():
	for node in hearth_container.get_children():
		hearth_container.remove_child(node)


func on_score_changed(new_score):
	label.text = "x " + str(new_score)


func on_game_over():
	game_over_panel.visible = true
	
	
func on_game_paused(is_paused):
	game_paused_panel.visible = is_paused
	
	
func on_game_unpaused():
	game_paused_panel.visible = false
	

func _on_save_button_pressed():
	save_and_load.save_data()


func _on_load_button_pressed():
	save_and_load.load_data()


func _on_button_pressed():
	game_controller.restart_level()


func _on_main_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://levels/main_menu/main_menu.tscn")
