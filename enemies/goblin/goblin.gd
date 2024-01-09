extends CharacterBody2D

@onready var right_ray_cast = $RightRayCast2D
@onready var left_ray_cast = $LeftRayCast2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_tree = $AnimationTree
@onready var state_machine = $AnimationTree.get("parameters/playback")
@onready var attack_hit_area = $AttackHitArea

@export var SPEED = 100.0
@export var DAMAGE = 1
@export var HEALTH = 30

var motion = Vector2.ZERO
var is_player_on_right = false
var can_see_player = false
var can_attack = false
var player = null
var max_distance_to_player = 26
var is_getting_hit = false
var is_dead = false

# Get the gravity from the project settings to be synced with RigidBody nodes.d
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	animation_tree.active = true


func _physics_process(_delta):
	if not is_dead:
		get_player_when_enter_ray_cast()
		on_move()
		on_attack()


func on_move():
	if not is_getting_hit:
		state_machine.travel("idle")
	
	if player: 
		velocity = Vector2((position.direction_to(player.position) * SPEED).x, velocity.y)
		var distance_to_player = position.distance_to(player.position)
		if distance_to_player >= max_distance_to_player and not is_getting_hit:
			state_machine.travel("run")
			move_and_slide()
		else:
			can_attack = true
	else:
		can_attack = false


func on_attack():
	if can_attack and not is_getting_hit and not is_dead:
		state_machine.travel("attack")
		
func on_attack_animation_finished():
	can_attack = false

func get_player_when_enter_ray_cast():
	if right_ray_cast.is_colliding():
		can_see_player = true
		player = right_ray_cast.get_collider()
		animated_sprite.flip_h = false;
		attack_hit_area.scale.x = 1
	elif left_ray_cast.is_colliding():
		can_see_player = true
		player = left_ray_cast.get_collider()
		animated_sprite.flip_h = true;
		attack_hit_area.scale.x = -1
	else:
		can_see_player = false
		player = false


func on_get_hit(damage):
	can_attack = false
	is_getting_hit = true
	HEALTH -= damage
	
	if HEALTH <= 0:
		is_dead = true
		state_machine.travel("death")
	else:
		state_machine.travel("get_hit")
	

func on_get_hit_animation_finished():
	is_getting_hit = false
	

func on_death_animation_finished():
	queue_free()
	

func _on_attack_hit_area_body_entered(body):
	body.on_get_hit(DAMAGE)
