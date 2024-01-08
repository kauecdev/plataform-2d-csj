extends Sprite2D

@onready var game_controller = GameController

func _on_area_2d_body_entered(_body):
	game_controller.on_next_level()
