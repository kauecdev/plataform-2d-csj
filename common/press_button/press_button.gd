extends RigidBody2D

@onready var button_not_pressed_sprite = $ButtonNotPressedSprite
@onready var button_pressed_sprite = $ButtonPressedSprite

@export var barrier: StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_press_area_body_entered(body):
	button_not_pressed_sprite.visible = false
	button_pressed_sprite.visible = true
	barrier.on_open()


func _on_press_area_body_exited(body):
	button_not_pressed_sprite.visible = true
	button_pressed_sprite.visible = false
	barrier.on_close()
