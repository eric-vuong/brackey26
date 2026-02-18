extends CanvasLayer
class_name Dialogue
## Handles character dialogue
# Variables
## Full dialogue block. key is first, value is next
var text_queue: Array
func _ready() -> void:
	hide()

func _input(event):
	pass
	if event is InputEventKey:
		if Input.is_action_just_pressed("interact"):
			_play_line()
		#get_viewport().set_input_as_handled()

## Play the dialogue scene on top.
## Disables player movement
func show_dialogue(dialogue_id: String) -> void:
	match dialogue_id:
		"test":
			text_queue = [
				["player", "This is a test message."],
				["player", "You can press interact to progress messages."]
			]
		"bonk":
			text_queue = [
				["player", "Ow"],
				["player", "That hurt."]
			]
	show()
	_play_line()

## Display the line and character speaking
func _play_line():
	if text_queue == []:
		close_dialogue()
		return
	var line = text_queue.pop_front()
	var actor = line[0]
	show_actor(actor)
	var text = line[1]
	$Label.text = text

	
func show_actor(actor_id: String = ""):
	for a in $Actors.get_children():
		a.hide()
	match actor_id:
		"player": $Actors/Player.show()
		"actor1": $Actors/Player.show()

func close_dialogue():
	hide()
