extends CharacterBody2D

@onready var player_sprite = $AnimatedSprite2D
@onready var animation_tree = $AnimationTree
@onready var state_machine = $AnimationTree.get("parameters/playback")
@onready var attack_hit_area = $AttackHitArea

@export var HEALTH = 100
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var DAMAGE = 10
@export var PUSH_FORCE = 30

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_double_jump = false
var is_double_jumping = false
var is_attacking = false
var is_getting_hit = false
var is_dead = false
var can_attack = true

func _ready():
	animation_tree.active = true


func _physics_process(delta):
	if not is_dead:
		on_jump(delta)
		on_move(delta)
		on_attack()


func on_move(delta):
	var direction = Input.get_axis("Left", "Right")
	if direction:
		player_sprite.flip_h = false if direction > 0 else true
		attack_hit_area.scale.x = 1 if direction > 0 else -1
		velocity.x = direction * SPEED
		if is_on_floor() and not is_attacking and not is_getting_hit:
			state_machine.travel("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor() and not is_attacking and not is_getting_hit:
			state_machine.travel("idle")
			
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().get_name() == "Stone":
			collision.get_collider().apply_central_impulse(-collision.get_normal() * PUSH_FORCE)


func on_jump(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		if not is_double_jumping and not is_attacking and not is_getting_hit:
			state_machine.travel("jump")
	else:
		is_double_jumping = false

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


func on_attack():
	if Input.is_action_just_pressed("Attack") and can_attack:
		can_attack = false
		is_attacking = true
		is_getting_hit = false
		state_machine.travel("attack")


func on_attack_animation_finished():
	await get_tree().create_timer(.1).timeout
	can_attack = true
	is_attacking = false
	

func on_get_hit(damage):
	is_attacking = false
	is_getting_hit = true
	HEALTH -= damage
	
	if HEALTH <= 0:
		state_machine.travel("death")
		is_dead = true
	else:
		state_machine.travel("get_hit")


func on_get_hit_finished():
	is_getting_hit = false


func on_death_finished():
	queue_free()


func _on_attack_hit_area_body_entered(body):
	body.on_get_hit(DAMAGE)
