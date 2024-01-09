extends CanvasLayer

@onready var save_and_load = SaveAndLoad
@onready var continue_button = $VBoxContainer/ContinueButton
@onready var quit_button = $VBoxContainer/QuitButton

var first_level_path = "res://levels/level_1.tscn"

func _ready():
	continue_button.disabled = !save_and_load.has_saved_game()
	if OS.get_name() == "Web":
		quit_button.visible = false
		quit_button.disabled = true
	

func _on_button_pressed():
	get_tree().change_scene_to_file(first_level_path)


func _on_continue_button_pressed():
	save_and_load.load_data()


func _on_quit_button_pressed():
	get_tree().quit()
