extends CanvasLayer
class_name Dialogue
## Handles character dialogue
# Variables
@export var text_delay: float = 0.035
@export var text_pause: float = 0.1
## Full dialogue block. key is first, value is next
var text_queue: Array
## Sound character makes when speaking. Defaults to blip.
var dialogue_sound: String = "blip.wav"
@onready var main: Main = get_tree().get_nodes_in_group("Main")[0]
@onready var sound: Sound = get_tree().get_nodes_in_group("Sound")[0]

func _ready() -> void:
	$Timer.wait_time = text_delay
	hide()

func _input(event):
	pass
	if event is InputEventKey:
		if Input.is_action_just_pressed("interact"):
			# If still playing, show entire line
			if $Label.visible_characters < $Label.text.length():
				$Label.visible_characters = $Label.text.length()
				$Timer.stop()
			else:
				# Move to next line
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
				["hurt", "Ow, that hurt."],
				["frown", "Why did I think hitting that block with my head was a good idea?"]
			]
		"knight":
			text_queue = [
				["knight", "If you wish to pass, you must defeat me."],
				["player", "But, I don't have an attack button."],
				["player", "Maybe you could just let me past?"],
				["smile", "Pretty please?"],
				["knight", "..."],
			]
		"cactus":
			text_queue = [
				["suprised", "Woah, what a humongous..."],
				["frown", "Cactus? Cucumber?"],
				["smile", "But that smile is cute."]
			]
		"sign":
			text_queue = [
				["frown", '"Closed during ongoing construction"'],
				["player", "I don't think I can jump over this for some reason."],
				["player", "Guess I'll come back later then."]
			]
		"blue_key_got":
			text_queue = [
				["player", 'This key seems important.'],
				["player", "And it looks like the path to the right is open."]
			]
		"red_key_got":
			text_queue = [
				["frown", "Ugh, I'm drenched."],
				["player", "At least I got this red key."],
				["player", "But how did I end up here?"],
			]
		"door":
			text_queue = [
				["player", "It looks like I'll need both keys to open this door."],
				["player", "I wonder what could behind it?"]
			]
		"credits":
			text_queue = [
				["player", '"Game by Robstherapy and CharQuThai"'],
				["frown", "That's the whole game!?"],
				["hurt", "I want a refund!"]
			]
		"spider":
			text_queue = [
				["hurt", "Eeek! I hate spiders."]
			]
		"statues":
			text_queue = [
				["player", "These are all just mannequins and props."],
				["player", "The door here is actually just painted on."],
				["player", "But I see an entrance up by those minecarts..."]
			]
		"water":
			text_queue = [
				["hurt", "Yuck! This water fountain tastes vile."]
			]
		"chest":
			text_queue = [
				["frown", "Why do all these chests need to be locked?"]
			]
		"drop":
			text_queue = [
				["frown", "It doesn't look like theres a way back up..."],
				["smile", "Good thing fall damage isn't enabled."]
			]
		"park_water":
			text_queue = [
				["smile", "They look like they are having fun."],
				["frown", "I think."],
			]
		"park_top":
			text_queue = [
				["player", "Honestly, I've been to worse parks."]
			]
			
	show()
	main.can_move = false
	_play_line()

## Display the line and character speaking
func _play_line():
	$Timer.wait_time = text_delay
	if text_queue == []:
		close_dialogue()
		return
	var line = text_queue.pop_front()
	var actor = line[0]
	show_actor(actor)

	var text = line[1]
	$Label.text = text
	$Label.visible_characters = 0
	$Timer.start()
	
	
## Type out the dialogue one character at a time
func _update_line():
	pass

## Display the characters portrait.
## Also set active voice
func show_actor(actor_id: String = ""):
	for a in $Actors.get_children():
		a.hide()
	# Default voice
	dialogue_sound = "blip.wav"
	match actor_id:
		"player":
			$Actors/Neutral.show()
			dialogue_sound = "blip.wav"
		"neutral":
			$Actors/Neutral.show()
			dialogue_sound = "blip.wav"
		"frown":
			$Actors/Frown.show()
			dialogue_sound = "blip.wav"
		"hurt":
			$Actors/Hurt.show()
			dialogue_sound = "blip.wav"
		"suprised":
			$Actors/Suprised.show()
			dialogue_sound = "blip.wav"
		"smile":
			$Actors/Smile.show()
			dialogue_sound = "blip.wav"
		"knight":
			$Actors/Knight.show()
			dialogue_sound = "knight.wav"
			$FrameLower.hide()
	if actor_id != "knight":
		$FrameLower.show()

func close_dialogue():
	hide()
	main.can_move = true

## Type out
func _on_timer_timeout() -> void:
	$Timer.wait_time = text_delay
	if $Label.visible_characters < $Label.text.length():
		# Add delay before next letter if needed
		if $Label.text[$Label.visible_characters] in [".",",","?","!"]:
			$Timer.wait_time = text_pause
		else:
			sound.play_dialogue(dialogue_sound)
		$Label.visible_characters += 1
	else:
		$Timer.stop()
