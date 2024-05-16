extends Node2D

@onready var score: Label = $Score

var myfirstint : int =  10
var isgameplaying : bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	var objey_physique: int = 0
	print("hello")
	
	var ma_variable = 9
	myfirstint = myfirstint - ma_variable
	print(myfirstint)
	
	ma_variable = Sprite2D.new()
	
	if myfirstint == 1:
		pass
	else:
		pass 
	
	var mon_tableau = [2, 4, 8, 10]
	
	for i in mon_tableau:
		print(i)
		
	for node in get_children():
		if node is RigidBody2D:
			objey_physique += 1
			
	print(objey_physique)
	
	score.text = str((objey_physique))
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
