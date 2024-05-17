extends Node2D

@onready var timer = $GameTimer
@onready var animated_sprite = $PolicierAnimations

@onready var voleur_animations = $voleurAnimations

var isgameplaying : bool = true
var tooEarly : bool = false
var animationplayedonce : bool = false

signal levelwon 
signal levellost

var Gamewon : bool = false


var time : float = 6.0
var rng = RandomNumberGenerator.new()
var myrandomnumber : float

# Called when the node enters the scene tree for the first time.
func _ready():
	myrandomnumber = rng.randf_range(2.0, 4.0)	
	print(time)
	print(myrandomnumber)
	animated_sprite.play("PolicierNotWatching")
	voleur_animations.play("NotStealing")
	
	_startGame()
	pass
	
func _startGame():
	if isgameplaying == true :
		timer.start()
		print("timerStarted")
		isgameplaying = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time = timer.time_left
		
	if time < myrandomnumber + 0.8 && time > myrandomnumber && tooEarly == false:
		print("ChatIsAboutToSteal")
		voleur_animations.play("AboutTosteal")
		
		if Input.is_action_just_pressed("Action"):
			voleur_animations.play("TooEarly")
			Gamewon = false
			tooEarly = true
			
	elif time < myrandomnumber && time > myrandomnumber - 1.3 :
			if Gamewon == false  && tooEarly == false :			
				voleur_animations.play("STealing")
			elif tooEarly == true :
				animated_sprite.play("PolicierFailed")
				
			if Input.is_action_just_pressed("Action") && tooEarly == false:
				animated_sprite.play("PolicierWatchSucceed")
				voleur_animations.play("Busted")
				print("you Turned around in time")
				Gamewon = true
	elif time < myrandomnumber - 1.3 && Gamewon == false && tooEarly == false:
		
		if animationplayedonce == false:
			voleur_animations.play("GotAway")
			animationplayedonce = true
		animated_sprite.play("PolicierFailed")
		
		
	
	pass


func _on_timer_timeout():
	print("timerEnded")
	if Gamewon == true :
		levelwon.emit()
	else :
		levellost.emit()
	timer.stop()
	pass # Replace with function body.
