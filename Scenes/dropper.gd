extends Node2D

var cam: Camera2D
@onready var main: Main = get_tree().get_nodes_in_group("Main")[0]
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
	main.change_level("parallax", {"position": Vector2(3820, 538), "direction": "left"})
