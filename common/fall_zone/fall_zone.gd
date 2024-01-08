extends Area2D

@onready var game_controller = GameController

func _on_body_entered(body):
	body.queue_free()
	game_controller.spawn_player_on_scene()
