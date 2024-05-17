extends CharacterBody2D


const SPEED = 700.0
const JUMP_VELOCITY = -400.0

var rng = RandomNumberGenerator.new()

var throws : float

@onready var pizzayoloanim = $AnimatedSprite2D

@onready var pate = $"../pateobjet/Pâte"

@onready var area_2d = $Area2D
@onready var timer = $Timer

signal pizzabad
signal pizzagud

func _ready():
	timer.start()
	pass # Replace with function body.
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta	
		
	if throws > 4 :
		pate.queue_free()
		pizzagud.emit()
		set_physics_process(false)
		
	
	var direction = Input.get_axis("pressleft", "pressright")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	


func _on_area_2d_body_entered(body : RigidBody2D):	
	var pateplayer : AnimationPlayer = body.get_node("AnimationPlayer")
	
	var tween = create_tween()
	
	pizzayoloanim.play("ThrowingUp")
	$boingPizza.play()
	
	throws += 1
	print(throws)
	print("howmanytimeswascalled")
	
	var randomnumber = rng.randf_range(-0.5, 0.5)	
	body.apply_central_impulse(Vector2(randomnumber, -1.5) * 950) 
	
	
	pass # Replace with function body.

func _on_lose_zone_body_entered(body):
	pizzabad.emit()
	print("patfellonfloor")
	pass # Replace with function body.


	pass # Replace with function body.
