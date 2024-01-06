extends AnimatedSprite2D

@onready var game_controller = GameController
@onready var animation_tree = $AnimationTree
@onready var state_machine = $AnimationTree.get("parameters/playback")
@onready var pickup_collision = $PickupArea/CollisionShape2D

var is_being_pickup = false

func _ready():
	animation_tree.active = true


func _process(delta):
	if not is_being_pickup:
		state_machine.travel("idle")


func _on_area_2d_body_entered(body):
	is_being_pickup = true
	pickup_collision.set_deferred("disabled", true)
	state_machine.travel("pickup")
	game_controller.on_get_coin()


func on_pickup_animation_finished():
	queue_free()
