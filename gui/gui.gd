extends CanvasLayer

@onready var game_controller = GameController
@onready var label = $Label

func _ready():
	game_controller.connect("score_changed", _on_score_changed)
	
func _on_score_changed(new_score):
	label.text = "x " + str(new_score)
