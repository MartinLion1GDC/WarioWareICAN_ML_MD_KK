extends Node2D

@onready var timer = $GameTimer

signal levelwon 
signal levellost

var isgameplaying : bool = true
var Gamewon : bool = false

var pédalage : int = 0
var droite : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
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
		
	if  pédalage > 20 :
		Gamewon = true;

func _on_game_timer_timeout():
	print("time out")
	if Gamewon == true :
		levelwon.emit()
	else :
		levellost.emit()
	timer.stop()
	pass # Replace with function body.
