extends Node2D


@warning_ignore("unused_parameter")
func _on_box_trigger_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
	if owner != null:
		owner.oof()


@warning_ignore("unused_parameter")
func _on_item_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
	if $Item.visible:
		print("got item")
		$Item.hide()
