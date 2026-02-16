extends CanvasLayer
class_name PauseMenu
## Shown when game is paused.
## Also has options in this screen
# Variables
# Audio buses
var master = AudioServer.get_bus_index("Master")
var music = AudioServer.get_bus_index("Music")
var effect = AudioServer.get_bus_index("Effect")
# Functions

func _ready() -> void:
	# Default master volume to 50%
	_on_master_slider_value_changed(50)
	_on_music_slider_value_changed(50)
	_on_effect_slider_value_changed(50)

func _input(_event):
	if Input.is_action_just_pressed("pause"):
		get_viewport().set_input_as_handled()
		_on_resume_pressed()

## Resume game
func _on_resume_pressed() -> void:
	owner.get_tree().paused = false
	$Control/MarginContainer/VBoxContainer/Keybinds.unbind_all()
	hide()

## Change master volume
func _on_master_slider_value_changed(value: float) -> void:
	value = value / 100
	AudioServer.set_bus_volume_db(master, linear_to_db(value))


func _on_music_slider_value_changed(value: float) -> void:
	value = value / 100
	AudioServer.set_bus_volume_db(music, linear_to_db(value))


func _on_effect_slider_value_changed(value: float) -> void:
	value = value / 100
	AudioServer.set_bus_volume_db(effect, linear_to_db(value))
