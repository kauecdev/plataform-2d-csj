extends RigidBody2D

@onready var button_not_pressed_sprite = $ButtonNotPressedSprite
@onready var button_pressed_sprite = $ButtonPressedSprite

@export var barrier: StaticBody2D

var player = null
var stone = null

func _on_press_area_body_entered(body):
	if body is Player:
		player = body
	elif body.get_name(): 
		stone = body
		
	button_not_pressed_sprite.visible = false
	button_pressed_sprite.visible = true
	barrier.on_open()


func _on_press_area_body_exited(body):
	if body is Player:
		player = null
	elif body.get_name(): 
		stone = null
		
	if player == null and stone == null:
		button_not_pressed_sprite.visible = true
		button_pressed_sprite.visible = false
		barrier.on_close()
