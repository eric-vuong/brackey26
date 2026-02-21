extends Node2D
class_name Main
## Main scene. All other scenes must be children of this
# Variables
## The current loaded scene
@export var scene: Node2D
## Contains all level scenes. key is name, value is node itself, set during ready.
@export var levels: Dictionary = {
	"parallax": null,
	"platform_level": null,
	"dropper": null,
}
## All movement functions should check this first. Prevent movement inputs (but not physics)
var can_move: bool = true

# For level changing
var new_level: String
var new_level_options: Dictionary

# Functions
func _ready() -> void:
	$PauseMenu.hide()
	# Get all levels added
	for level in levels.keys():
		var level_path = "res://Scenes/" + level + ".tscn"
		var new_scene = load(level_path).instantiate()
		levels[level] = new_scene
	set_level("parallax")
	

func _input(_event):
	if Input.is_action_just_pressed("pause"):
		get_viewport().set_input_as_handled()
		_on_pause_button_pressed()
## Given level name and options, perform transition to new scene
func change_level(level: String, options: Dictionary = {}):
	print("Change level")
	# First fade out level and lock controls
	can_move = false
	$Transition.to_black()
	new_level = level
	new_level_options = options
	$SceneChangeTimer.start()
	# Continue with scene change timer

## Given level name, set it to be the current scene.
func set_level(level: String):
	remove_child(scene)
	scene = levels[level]
	add_child(scene)

func show_dialogue(dialogue_id: String):
	$Dialogue.show_dialogue(dialogue_id)

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



## Finish loading into new scene
func _on_scene_change_timer_timeout() -> void:
	pass # Replace with function body.
	set_level(new_level)
	# Set positon
	if "position" in new_level_options.keys():
		scene.set_player_position(new_level_options["position"])
	if "direction" in new_level_options.keys():
		scene.set_player_direction(new_level_options["direction"])
	$Transition.to_clear()
	can_move = true
	
	


func _on_tp_pressed() -> void:
	pass # Replace with function body.
	change_level("platform_level",{"position": Vector2(100, 920), "direction": "right"})
