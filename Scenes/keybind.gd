extends Button
class_name Keybind
## Allows rebinding controls
# Variables
## What input this corresponds to
@export var action: String
## Default control
var default_key: InputEvent
var binding: bool = false
## Records last set key
var last_text: String = ""

func _ready() -> void:
	# Get default key
	default_key = InputMap.action_get_events(action)[0]
	default_key.pressed = true
	set_key_text(InputMap.action_get_events(action)[0].as_text())
	$Label.text = action.capitalize()
	

func _input(event):
	if binding:
		if event is InputEventKey:
			get_viewport().set_input_as_handled()
			binding = false
			InputMap.action_erase_events(action)
			InputMap.action_add_event(action, event)
			set_key_text(InputMap.action_get_events(action)[0].as_text())
	else:
		return

## Format and set the default key
func set_key_text(text_to_set: String):
	text = text_to_set.replace(" - Physical", "")
	last_text = text

func reset_key():
	binding = false
	InputMap.action_erase_events(action)
	InputMap.action_add_event(action, default_key)
	set_key_text(InputMap.action_get_events(action)[0].as_text())

## Unpress the button without setting a new key
func unbind():
	binding = false
	text = last_text

func _on_pressed() -> void:
	# Un press all others
	var all_keys: Array = get_tree().get_nodes_in_group("Keybinds")
	for key in all_keys:
		key.unbind()
	# Set new key
	text = "Press key"
	binding = true
