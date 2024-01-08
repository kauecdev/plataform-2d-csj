extends CanvasLayer

@onready var game_controller = GameController
@onready var save_and_load = SaveAndLoad
@onready var label = $Label

func _ready():
	_on_score_changed(game_controller.score)
	game_controller.connect("score_changed", _on_score_changed)
	
func _on_score_changed(new_score):
	label.text = "x " + str(new_score)


func _on_save_button_pressed():
	save_and_load.save_data()


func _on_load_button_pressed():
	save_and_load.load_data()
