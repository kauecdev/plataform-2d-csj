extends CharacterBody2D

@export var speed = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_input()

func get_input():
	var input_direction = Input.get_vector("Left", "Up", "Right", "Down")
	velocity = input_direction * speed
	print(velocity)
