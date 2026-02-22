extends Node2D
class_name WeirdPark
## Park scene
# Variables
## Can talk to this
var interact_target: String = ""
@onready var main: Main = get_tree().get_nodes_in_group("Main")[0]
# Functions
#func _process(delta: float) -> void:
	#print($TopDownPlayer.global_position)

func _input(_event):
	if Input.is_action_just_pressed("interact"):
		if interact_target in ["door"]:
			if main.can_move:
				get_viewport().set_input_as_handled()
				if main.has_blue_key and main.has_red_key:
					main.change_level("credits_room", {"position": Vector2(920, 380), "direction": "up"})
				else:
					main.show_dialogue(interact_target)

## Put player here
func set_player_position(pos: Vector2):
	$TopDownPlayer.global_position = pos
	#print("set pos", pos)
	#$TopDownPlayer.stop()

func set_player_direction(dir: String):
	$TopDownPlayer.set_dir(dir)

@warning_ignore("unused_parameter")
func _on_to_parallax_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
	main.change_level("parallax", {"position": Vector2(-1800, 920), "direction": "right"})
	await get_tree().create_timer(0.4).timeout
	set_player_position(Vector2(1810, 659))
	


@warning_ignore("unused_parameter")
func _on_key_room_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	$TopDownPlayer.can_interact(true)
	interact_target = "door"


@warning_ignore("unused_parameter")
func _on_key_room_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	$TopDownPlayer.can_interact(false)
	interact_target = ""
