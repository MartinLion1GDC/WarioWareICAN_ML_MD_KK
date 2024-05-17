extends Node2D

@onready var timer = $GameTimer

@onready var Dog_anim = $Iench/Dog_anm
@onready var angry_d_og_anim = $Iench/angryDOgAnim

signal levelwon 
signal levellost

var isgameplaying : bool = true
var Gamewon : bool = false



var pédalage : int = 0
var droite : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$DogBark.play()
	timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isgameplaying == true :
		if Input.is_action_just_pressed("pressleft") :
			if droite == false :
				pédalage += 1
				droite = true
				print(pédalage)
			
		elif Input.is_action_just_pressed("pressright") :
			if droite == true :
				pédalage += 1
				droite = false
				print(pédalage)
		
	if  pédalage > 15 :
		Gamewon = true;
		
	if timer.time_left < 0.5 && Gamewon == false && isgameplaying == true:
		print("loseanim")
		Dog_anim.play("Jumpthemailman")
		isgameplaying = false
	elif timer.time_left < 0.5 && Gamewon == true && isgameplaying == true:
		print("winanim")
		angry_d_og_anim.play("cute puppy")
		isgameplaying = false



func _on_game_timer_timeout():
	print("time out")
	if Gamewon == true :
		levelwon.emit()
	else :
		$cuteDog.play()
		levellost.emit()
	timer.stop()
	pass # Replace with function body.
