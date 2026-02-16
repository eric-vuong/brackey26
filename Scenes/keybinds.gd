extends ColorRect
class_name Keybinds
## Holds all the keybind nodes

# Functions

func _on_button_pressed() -> void:

	var all_keys: Array = get_tree().get_nodes_in_group("Keybinds")
	for key in all_keys:
		key.reset_key()

func unbind_all():
	var all_keys: Array = get_tree().get_nodes_in_group("Keybinds")
	for key in all_keys:
		key.unbind()
