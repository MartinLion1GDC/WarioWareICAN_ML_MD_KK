extends Node2D

@onready var timer = $CharacterBody2D/Timer

@onready var lose_zone = $LoseZone

var Gamewon : bool = false

signal levelwon 
signal levellost

# Called when the node enters the scene tree for the first time.
func _ready():
	var monchild = $CharacterBody2D
	monchild.pizzabad.connect(_pizzaonfloor)
	monchild.pizzagud.connect(_pizzagood)
	timer.start()
	$Musique.play()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _pizzaonfloor():
	Gamewon = false
	pass

func _pizzagood():
	Gamewon = true
	lose_zone.process_mode = Node.PROCESS_MODE_DISABLED
	pass

func _on_timer_timeout():
	print("timerEnded")
	if Gamewon == true :
		$Bravo.play()
		levelwon.emit()
	else :
		$mama_mia.play()
		levellost.emit()
	timer.stop()
	pass # Replace with function body.
