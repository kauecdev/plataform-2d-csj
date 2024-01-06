extends RigidBody2D

@export var barrier: StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_press_area_body_entered(body):
	barrier.on_open()


func _on_press_area_body_exited(body):
	barrier.on_close()
