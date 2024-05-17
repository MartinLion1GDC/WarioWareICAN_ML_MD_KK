extends Node2D

@onready var timer = $GameTimer
@onready var animated_sprite = $Policier/PolicierAnimations

@onready var voleur_animations = $Voleur/voleurAnimations

@onready var voleur_s_ong = $voleurSOng

@onready var grandma_lose = $GrandmaLose

@onready var grandma_win = $GrandmaWin

var isgameplaying : bool = true
var animationplayedonce : bool = false

signal levelwon 
signal levellost

var Gamewon : bool = false
var tooearly : bool = false

var time : float = 6.0
var rng = RandomNumberGenerator.new()
var myrandomnumber : float

# Called when the node enters the scene tree for the first time.
func _ready():
	myrandomnumber = rng.randf_range(2.0, 4.0)	
	print(myrandomnumber)
	animated_sprite.play("PolicierNotWatching")
	voleur_animations.play("NotStealing")
	
	voleur_s_ong.play()
	
	_startGame()
	pass
	
func _startGame():
	
	if isgameplaying == true :
		timer.start()
		isgameplaying = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time = timer.time_left
	print(time)
		
	if time < myrandomnumber + 0.8 && time > myrandomnumber && tooearly == false:
		voleur_animations.play("AboutTosteal")
		$PolicierSuspicieux.play()
		if Input.is_action_just_pressed("Action") :
			tooearly = true
			animated_sprite.play("PolicierFailed")
			voleur_animations.play("Tooearly")
			Gamewon = false
		
		
	elif time < myrandomnumber && time > myrandomnumber - 1.2 && tooearly == false:
			
				
			if Input.is_action_just_pressed("Action") :
				animated_sprite.play("PolicierWatchSucceed")
				voleur_animations.play("Busted")
				print("you Turned around in time")
				
				grandma_win.play()
				
				Gamewon = true
				
			if Gamewon == false :			
				voleur_animations.play("STealing")
				print("YOU LOSE")
				
	elif time < myrandomnumber - 1.2 && Gamewon == false && tooearly == false:
		
		if animationplayedonce == false:
			grandma_lose.play()
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
