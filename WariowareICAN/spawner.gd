extends Node2D

#var ma_scene := preload("res://potirobot.tscn")

@export_file("*.tscn") var chemin: String
@export var quantite: int = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("spawn"):
		print("Action!")
		
		var ma_scene := load(chemin)
		
		var instance = ma_scene.instantiate()
		
		add_child(instance)
	
	pass
