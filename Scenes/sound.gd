extends Node2D
class_name Sound
## Handles playing sound effects and music.
# Variables
## Sound file extension must be one of these
const FILE_TYPES = ["wav", "ogg", "mp3"]
## Sound effect dict. Key is sound file name, value is the loaded resource
var sound_list: Dictionary = {}
## Music dict. Key is file name, value is resource
var music_list: Dictionary = {}
## Array of all audio stream player nodes
var audio_players: Array = []
## File name of current song
var current_music: String = ""
## Used to pitch shift dialogue
var rng := RandomNumberGenerator.new()
func _ready() -> void:
	# Setup sound list
	var dir = "res://Assets/sound/"
	var sound_directory = DirAccess.open(dir)
	for sound_name in (sound_directory.get_files()):
		# Need to use .import files to find the actual files
		if sound_name.get_extension() == "import":
			sound_name = sound_name.replace(".import", "")
			if sound_name.get_extension() in FILE_TYPES:
				sound_list[str(sound_name)] = load(str(dir) + str(sound_name))
	# Fill array with stream players
	audio_players = $AudioPlayers.get_children()
	
	# Setup music
	var m_dir = "res://Assets/music/"
	var music_directory = DirAccess.open(m_dir)
	for music_name in (music_directory.get_files()):
		if music_name.get_extension() == "import":
			music_name = music_name.replace(".import", "")
			if music_name.get_extension() in FILE_TYPES:
				music_list[str(music_name)] = load(str(m_dir) + str(music_name))

## Start playing dialogue blip
func play_dialogue(sound: String):
	if sound == "":
		$DialoguePlayer.stop()
		return
	if sound not in sound_list:
		return
	if $DialoguePlayer.playing == true:
		if $DialoguePlayer.stream == sound_list[sound]:
			# Already actively playing this sound
			return
	# Play the dialogue blip
	$DialoguePlayer.pitch_scale = rng.randf_range(0.95, 1.08)
	$DialoguePlayer.stream = sound_list[sound]
	$DialoguePlayer.play()

## Play music track. Only 1 song at a time, that loops.
func play_music(music: String = "", decibels: float = 0.0) -> void:
	if music == "":
		current_music = ""
		$MusicPlayer.stream = null
		return
	if current_music == music:
		# Just reset volume if music is the same
		$MusicPlayer.volume_db = decibels
		return
	if music in music_list:
		$MusicPlayer.stream = music_list[music]
		current_music = music
		$MusicPlayer.play()
		# Reset volume to base
		$MusicPlayer.volume_db = decibels
		return
	print("WARNING: Failed to find music: ", music)


func play(sound: String, decibels: float = 0.0, bus: String = "Effect") -> void:
	# Check sound exists
	if sound not in sound_list.keys():
		print("Error: sound file not found: ", sound)
		return
	# If sound has a player, just have it play it again
	var audio_player = find_audio_stream(sound)
	if audio_player != null:
		# Found it just play it
		_play_sound("repeat", audio_player, decibels, bus)
		return
	# Look for a empty, then free player to use
	var other_audio_players = get_available_players()
	var empty_players = other_audio_players[0]
	var free_players = other_audio_players[1]
	
	# Use one of these players
	if len(empty_players) != 0:
		# Shuffled, so use empty 0
		_play_sound(sound, empty_players[0], decibels, bus)
		return
	if len(free_players) != 0:
		_play_sound(sound, free_players[0], decibels, bus)
		return
	print("WARNING: Failed to find a free sound player. Dropped sound: ", sound)
	

## Given the sound file name, find if a player is streaming it
func find_audio_stream(sound: String) -> AudioStreamPlayer:
	var audio_resource = sound_list[sound]
	for p in audio_players:
		if p.stream == audio_resource:
			return p
	return null

## Get players that either have null stream or are not playing.
## Returns 2d array. first is players with null stream, second is players not playing
func get_available_players() -> Array:
	var empty_players = []
	var free_players = []
	for p in audio_players:
		if p.stream == null:
			empty_players.append(p)
		elif p.playing == false:
			free_players.append(p)
	empty_players.shuffle()
	free_players.shuffle()
	return [empty_players, free_players]

## Internal use only. 
## Has the specific audio player play the sound
func _play_sound(sound: String, audio_player: AudioStreamPlayer, decibels: float = 0.0, bus: String = "Effect") -> void:
	if sound != "repeat":
		# Set new sound if not repeating
		audio_player.stream = sound_list[sound]
	audio_player.volume_db = decibels
	audio_player.bus = bus
	audio_player.play()
