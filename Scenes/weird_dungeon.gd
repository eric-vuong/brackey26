extends Node2D
class_name WeirdDungeon
## Park scene
# Variables
var interact_target: String = ""
@onready var main: Main = get_tree().get_nodes_in_group("Main")[0]
# Functions

#func _process(delta: float) -> void:
	#print($TopDownPlayer.global_position)
func _input(_event):
	if Input.is_action_just_pressed("interact"):
		if interact_target != "":
			if main.can_move:
				get_viewport().set_input_as_handled()
				main.show_dialogue(interact_target)
				
## Put player here
func set_player_position(pos: Vector2):
	print("was at ", $TopDownPlayer.global_position)
	$TopDownPlayer.global_position = pos
	
	#print("set pos", pos)
	#$TopDownPlayer.stop()

func set_player_direction(dir: String):
	$TopDownPlayer.set_dir(dir)

#func _on_to_parallax_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	#pass # Replace with function body.
	#main.change_level("parallax", {"position": Vector2(-1800, 920), "direction": "right"})
	#await get_tree().create_timer(0.4).timeout
	#set_player_position(Vector2(1810, 659))
	#


func _on_to_dropper_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
	main.change_level("dropper", {"position": Vector2(633, 393), "direction": "right"})
	await get_tree().create_timer(0.4).timeout
	set_player_position(Vector2(1810, 659))

func _on_to_parallax_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
	main.change_level("parallax", {"position": Vector2(3800, 890), "direction": "left"})
	await get_tree().create_timer(0.4).timeout
	set_player_position(Vector2(1810, 659))


func _on_spider_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	$TopDownPlayer.can_interact(true)
	interact_target = "spider"

func _on_spider_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	$TopDownPlayer.can_interact(false)
	interact_target = ""


func _on_statues_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	$TopDownPlayer.can_interact(true)
	interact_target = "statues"


func _on_statues_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	$TopDownPlayer.can_interact(false)
	interact_target = ""


func _on_water_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	$TopDownPlayer.can_interact(true)
	interact_target = "water"


func _on_water_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	$TopDownPlayer.can_interact(false)
	interact_target = ""


func _on_chest_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	$TopDownPlayer.can_interact(true)
	interact_target = "chest"


func _on_chest_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	$TopDownPlayer.can_interact(false)
	interact_target = ""
