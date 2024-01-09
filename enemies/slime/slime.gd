extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_tree = $AnimationTree
@onready var state_machine = $AnimationTree.get("parameters/playback")

@export var HEALTH = 20
@export var SPEED = 70
@export var DAMAGE = 1

var direction = 1
var is_getting_hit = false
var is_dead = false

func _ready():
	animation_tree.active = true


func _physics_process(_delta):
	if not is_dead:
		if not is_getting_hit:
			state_machine.travel("walk")
		velocity.x = direction * SPEED
		move_and_slide()
		animated_sprite.flip_h = true if direction > 0 else false
		
		if is_on_wall():
			direction = direction * -1


func _on_hit_area_body_entered(body):
	body.on_get_hit(DAMAGE)


func on_get_hit(damage):
	is_getting_hit = true
	HEALTH -= damage
	
	if HEALTH <= 0:
		state_machine.travel("death")
	else:
		state_machine.travel("get_hit")
	

func on_get_hit_finished():
	is_getting_hit = false
	
	
func on_death():
	queue_free()
