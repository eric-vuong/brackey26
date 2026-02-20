extends Node2D

var cam: Camera2D
func _ready() -> void:
	pass
	cam = $Camera2D
	
func _physics_process(delta):
	cam.global_position[1] = clamp($Platformer.global_position[1], 540,3713)
