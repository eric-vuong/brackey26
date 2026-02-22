extends Node2D
class_name WeirdPark
## Park scene
# Variables
@onready var main: Main = get_tree().get_nodes_in_group("Main")[0]
# Functions
#func _process(delta: float) -> void:
	#print($TopDownPlayer.global_position)
## Put player here
func set_player_position(pos: Vector2):
	$TopDownPlayer.global_position = pos
	#print("set pos", pos)
	#$TopDownPlayer.stop()

func set_player_direction(dir: String):
	$TopDownPlayer.set_dir(dir)

func _on_to_parallax_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
	main.change_level("parallax", {"position": Vector2(-1800, 920), "direction": "right"})
	await get_tree().create_timer(0.4).timeout
	set_player_position(Vector2(1810, 659))
	
