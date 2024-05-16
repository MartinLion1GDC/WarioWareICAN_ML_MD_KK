extends Node

var Levelwin : bool  = false

var  randomnumber : int

var rng = RandomNumberGenerator.new()
@onready var scoreLabel = $Node2D/Score
@onready var timer = $Node2D/Timer

var Micro : Array = ["res://Jeux/facteur_jeu.tscn","res://Jeux/pizza_yolocharacter.tscn","res://Jeux/PoliceJeu.tscn"]

@onready var anim_transit = $Node2D/Person1/AnimationPlayer

@onready var transition_animation_player = $Node2D/TransitionAnimationPlayer

var lives : int = 3 
@onready var Vies : Array =[$Node2D/Person1,$Node2D/Person2,$Node2D/Person3,$Node2D/Person4]

var monchild
var score : int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	
	timer.start()
	
	for i in Micro :
		print(i)
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _changelevel():
	scoreLabel.visible = false
	randomnumber = rng.randi_range(0,2)
	var microgame : String = Micro[randomnumber]
	var game : = load(microgame)
	monchild = game.instantiate()
	add_child(monchild)
	monchild.levelwon.connect(_waslevelwon)
	monchild.levellost.connect(_waslevellost)

func _waslevelwon() :
	$win_minijeu.play()
	
	timer.start()
	transition_animation_player.play("dezoomin")
	var tween = create_tween()
	tween.tween_property(monchild, "scale",Vector2(0.5,0.5), 1)
	tween.tween_callback(monchild.queue_free)
	score += 1
	scoreLabel.visible = true
	scoreLabel.text = str(score)
	print("Winner")
	
	
func _waslevellost():
	var anim = Vies[0].get_node("AnimationPlayer")
	lives = lives - 1
	
	anim.play("disappear")
	
	$lose_minijeu.play()
	
	timer.start()
	transition_animation_player.play("dezoomin")
	var tween = create_tween()
	tween.tween_property(monchild, "scale",Vector2(0.3,0.3), 0.1)
	tween.tween_callback(monchild.queue_free)
	score += 1
	scoreLabel.visible = true
	scoreLabel.text = str(score)
	print("loser")
	
	pass



func _on_timer_timeout():	
	$introNewMicroGame.play()
	transition_animation_player.play("zoomIn")
	
	
