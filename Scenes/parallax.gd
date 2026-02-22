extends Node2D
var speed = 1000
var cam: Camera2D
## Used with interact key to talk to something
var interact_target: String = ""
var step_area: String = ""
@onready var main: Main = get_tree().get_nodes_in_group("Main")[0]
@onready var sound: Sound = get_tree().get_nodes_in_group("Sound")[0]
func _ready() -> void:
	cam = $Camera2D

func _input(_event):
	if Input.is_action_just_pressed("interact"):
		if interact_target in ["knight", "sign"]:
			if main.can_move:
				get_viewport().set_input_as_handled()
				main.show_dialogue(interact_target)
				$Platformer.stop()
		
@warning_ignore("unused_parameter")
func _physics_process(delta):
	cam.global_position[0] = clamp($Platformer.global_position[0], -1103, 2976)

## Put player here
func set_player_position(pos: Vector2):
	$Platformer.global_position = pos
	# Also check and destroy sign
	if main.has_blue_key or main.has_red_key:
		for c in $SignPost.get_children():
			c.queue_free()
		$SignPost.hide()

## Have player face left/right/up/down
func set_player_direction(direction: String):
	if direction == "left":
		$Platformer.flip_sprite(true)
	elif direction == "right":
		$Platformer.flip_sprite(false)

func _on_button_pressed() -> void:
	pass # Replace with function body.
	

@warning_ignore("unused_parameter")
func _on_to_platformer_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	main.change_level("platform_level",{"position": Vector2(100, 920), "direction": "right"})


@warning_ignore("unused_parameter")
func _on_to_dropper_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	#main.change_level("dropper", {"position": Vector2(633, 393), "direction": "right"})
	main.change_level("WeirdDungeon", {"position": Vector2(74, 759), "direction": "right"})


@warning_ignore("unused_parameter")
func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	$Platformer.can_interact()
	interact_target = "knight"

@warning_ignore("unused_parameter")
func _on_area_2d_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	$Platformer.can_interact(false)
	interact_target = ""


@warning_ignore("unused_parameter")
func _on_death_zone_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
	main.can_move = false
	$Knight.flip_h = false
	$Platformer.flip_sprite(true)
	$Platformer.stop()
	await get_tree().create_timer(2.25).timeout
	$Explosion.play("Explode")
	sound.play("explode.wav")
	await get_tree().create_timer(1.25).timeout
	main.can_move = true
	$Knight.queue_free()
	
## Used to track when to delete knight
var exp_frame: int = 0
func _on_explosion_frame_changed() -> void:
	pass # Replace with function body.
	exp_frame += 1
	if exp_frame == 4:
		$Knight.hide()
	if exp_frame == 11:
		await get_tree().create_timer(0.35).timeout
		$Explosion.queue_free()


@warning_ignore("unused_parameter")
func _on_sign_talk_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
	$Platformer.can_interact()
	interact_target = "sign"


@warning_ignore("unused_parameter")
func _on_sign_talk_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	$Platformer.can_interact(false)
	interact_target = ""


@warning_ignore("unused_parameter")
func _on_to_park_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
	main.change_level("WeirdPark", {"position": Vector2(1810, 659), "direction": "left"})


func _on_grass_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
	step_area = "grass"


func _on_rock_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
	step_area = "rock"
