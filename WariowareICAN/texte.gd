extends Node2D

@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()


func _on_timer_timeout():
	queue_free()
