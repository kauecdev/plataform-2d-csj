extends RigidBody2D

@onready var button_not_pressed_sprite = $ButtonNotPressedSprite
@onready var button_pressed_sprite = $ButtonPressedSprite

@export var barrier: StaticBody2D

func _on_press_area_body_entered(_body):
	button_not_pressed_sprite.visible = false
	button_pressed_sprite.visible = true
	barrier.on_open()


func _on_press_area_body_exited(_body):
	button_not_pressed_sprite.visible = true
	button_pressed_sprite.visible = false
	barrier.on_close()
