extends StaticBody2D

@onready var animation_player = $AnimationPlayer

var is_opening = false
var is_closing = false
var is_closed = true

func _process(delta):
	if not is_opening and is_closed:
		animation_player.play("closed")

func on_open():
	is_opening = true
	is_closed = false
	animation_player.play("opening")
	
func on_close():
	is_closing = true
	animation_player.play_backwards("opening")
	
func on_opening_animation_backwards_finished():
	if is_closing:
		is_opening = false
		is_closing = false
		is_closed = true
		
