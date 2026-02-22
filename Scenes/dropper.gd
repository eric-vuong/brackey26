extends Node2D
var step_area: String = ""
var cam: Camera2D
@onready var main: Main = get_tree().get_nodes_in_group("Main")[0]
@onready var sound: Sound = get_tree().get_nodes_in_group("Sound")[0]
func _ready() -> void:
	pass
	cam = $Camera2D

## Put player here
func set_player_position(pos: Vector2):
	$Platformer.global_position = pos

## Have player face left/right/up/down
func set_player_direction(direction: String):
	if direction == "left":
		$Platformer.flip_sprite(true)
	elif direction == "right":
		$Platformer.flip_sprite(false)

func _physics_process(delta):
	cam.global_position[1] = clamp($Platformer.global_position[1], 540,3713)


func _on_pool_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
	sound.play("dive.wav")
	main.change_level("WeirdPark", {"position": Vector2(920, 500), "direction": "left"})


func _on_item_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
	if $Item.visible:
		print("got item")
		$Item.hide()
		
		$Item.queue_free()
		
		main.has_red_key = true
		main.got_key()
		# Play dialogue
		$Item.queue_free()
		
		await get_tree().create_timer(1.4).timeout
		main.show_dialogue("red_key_got")
		# Kill item
		
