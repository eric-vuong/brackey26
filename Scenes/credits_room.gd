extends Node2D
class_name CreditsRoom
var interact_target
@onready var main: Main = get_tree().get_nodes_in_group("Main")[0]

func _input(_event):
	if Input.is_action_just_pressed("interact"):
		if interact_target == "credits":
			if main.can_move:
				get_viewport().set_input_as_handled()
				main.show_dialogue("credits")


## Put player here
func set_player_position(pos: Vector2):
	$TopDownPlayer.global_position = pos
	#print("set pos", pos)
	#$TopDownPlayer.stop()

func set_player_direction(dir: String):
	$TopDownPlayer.set_dir(dir)


@warning_ignore("unused_parameter")
func _on_to_park_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
	
	main.change_level("WeirdPark", {"position": Vector2(920, 620), "direction": "up"})
	await get_tree().create_timer(0.4).timeout
	set_player_position(Vector2(920, 380))


func _on_tomb_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
	$TopDownPlayer.can_interact(true)
	interact_target = "credits"

func _on_tomb_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
	$TopDownPlayer.can_interact(false)
	interact_target = ""
