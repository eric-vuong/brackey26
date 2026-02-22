extends CanvasLayer
class_name Transition
## Handles the fade in transition between levels.

# Functions
func _ready() -> void:
	show()
	var tween : Tween = get_tree().create_tween()
	tween.tween_property($ColorRect, "modulate:a", 0, 0.1)#.set_delay(.5)


func _on_button_pressed() -> void:
	to_clear()


func _on_button_2_pressed() -> void:
	to_black()

## Go from black to transparent
func to_clear():
	var tween : Tween = get_tree().create_tween()
	tween.tween_property($ColorRect, "modulate:a", 0, 0.33)#.set_delay(.5)

## Go from transparent to black
func to_black():
	var tween : Tween = get_tree().create_tween()
	tween.tween_property($ColorRect, "modulate:a", 1, 0.33)
