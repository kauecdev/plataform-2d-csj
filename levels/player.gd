extends CharacterBody2D

@onready var player_sprite = $AnimatedSprite2D
@onready var animation_tree = $AnimationTree
@onready var state_machine = $AnimationTree.get("parameters/playback")

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_double_jump = false
var is_double_jumping = false
var is_attacking = false


func _ready():
	animation_tree.active = true


func _physics_process(delta):
	jump(delta)
	move()
	attack()


func move():
	var direction = Input.get_axis("Left", "Right")
	if direction:
		player_sprite.flip_h = false if direction > 0 else true
		velocity.x = direction * SPEED
		if is_on_floor() and not is_attacking:
			state_machine.travel("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor() and not is_attacking:
			state_machine.travel("idle")
			
	move_and_slide()


func jump(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		if not is_double_jumping and not is_attacking:
			state_machine.travel("jump")
		

	if Input.is_action_just_pressed("Up"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			can_double_jump = true
		elif can_double_jump:
			velocity.y = JUMP_VELOCITY
			can_double_jump = false
			is_double_jumping = true
			if not is_attacking:
				state_machine.travel("double_jump")
		else:
			is_double_jumping = false


func attack():
	if Input.is_action_just_pressed("Attack"):
		is_attacking = true
		state_machine.travel("attack")


func on_attack_animation_finished():
	is_attacking = false
	

func _on_attack_hit_area_area_entered(area):
	pass # Replace with function body.


