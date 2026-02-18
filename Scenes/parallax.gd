extends Node2D
var speed = 1000
var cam: Camera2D
func _ready() -> void:
	pass
	cam = $Camera2D

@warning_ignore("unused_parameter")
func _physics_process(delta):
	cam.global_position[0] = clamp($Platformer.global_position[0], -1103, 2976)
	#print($Platformer.global_position[0])
