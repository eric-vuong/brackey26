extends Node2D
class_name Main
## Main scene. All other scenes must be children of this

# Functions
func _ready() -> void:
	$PauseMenu.hide()

func _input(_event):
	if Input.is_action_just_pressed("pause"):
		get_viewport().set_input_as_handled()
		_on_pause_button_pressed()


## Pause the game
func _on_pause_button_pressed() -> void:
	# Allow unpausing with this button as well
	if get_tree().paused == true:
		$PauseMenu._on_resume_pressed()
		return
	get_tree().paused = true
	$PauseMenu.show()


func _on_m_pressed() -> void:
	var rng_m = $Sound.music_list.keys()
	if len(rng_m) == 0:
		return
	rng_m.shuffle()
	print("Testing music: ", rng_m[0])
	$Sound.play_music(rng_m[0])


func _on_s_pressed() -> void:
	var rng_s = $Sound.sound_list.keys()
	if len(rng_s) == 0:
		return
	rng_s.shuffle()
	print("Testing sound: ", rng_s[0])
	$Sound.play(rng_s[0])
