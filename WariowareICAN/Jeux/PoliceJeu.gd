extends Node2D

@onready var timer = $GameTimer
@onready var animated_sprite = $PolicierAnimations

@onready var voleur_animations = $voleurAnimations

var isgameplaying : bool = true
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
	$PolicierSuspicieux.play()
	
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
	print(time)
		
	if time < myrandomnumber + 0.8 && time > myrandomnumber:
		print("ChatIsAboutToSteal")
		voleur_animations.play("AboutTosteal")
		pass
	elif time < myrandomnumber && time > myrandomnumber - 1.2 :
			if Gamewon == false :			
				voleur_animations.play("STealing")
				$GrandmaLose.play()
			if Input.is_action_just_pressed("PolicierTurnAround") :
				animated_sprite.play("PolicierWatchSucceed")
				voleur_animations.play("Busted")
				print("you Turned around in time")
				$GrandmaWin.play()
				Gamewon = true
	elif time < myrandomnumber - 1.2 && Gamewon == false :
		
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
