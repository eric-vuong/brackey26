extends Node2D

@onready var main: Main = get_tree().get_nodes_in_group("Main")[0]

## Used with interact key to talk to something
var interact_target: String = ""
func _input(_event):
	if Input.is_action_just_pressed("interact"):
		if interact_target == "cactus":
			if main.can_move:
				get_viewport().set_input_as_handled()
				main.show_dialogue("cactus")
				$Platformer.stop()
func set_player_position(pos: Vector2):
	$Platformer.global_position = pos

func set_player_direction(direction: String):
	if direction == "left":
		$Platformer.flip_sprite(true)
	elif direction == "right":
		$Platformer.flip_sprite(false)

@warning_ignore("unused_parameter")
func _on_box_trigger_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	await get_tree().create_timer(0.3).timeout
	main.show_dialogue("bonk")
	$Platformer.stop()


@warning_ignore("unused_parameter")
func _on_item_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
	if $Item.visible:
		print("got item")
		$Item.hide()
		
		$Item.queue_free()
		
		main.has_blue_key = true
		# Shrink cactus
		var tween = get_tree().create_tween()
		tween.tween_property($Cactus, "position", $Cactus.global_position + Vector2(0,400), 3)
		# Play dialogue
		await get_tree().create_timer(0.3).timeout
		main.show_dialogue("blue_key_got")
		$Platformer.stop()
		# Kill item
		$Item.queue_free()


func _on_to_parallax_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
	main.change_level("parallax", {"position": Vector2(3800, 538), "direction": "left"})


func _on_cactus_talk_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	$Platformer.can_interact(true)
	interact_target = "cactus"


func _on_cactus_talk_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	$Platformer.can_interact(false)
	interact_target = ""


func _on_to_park_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
	main.change_level("WeirdPark", {"position": Vector2(100, 659), "direction": "right"})
