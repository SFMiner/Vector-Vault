extends Node

var sfx_players: Array[AudioStreamPlayer] = []

@export var max_concurrent_sounds: int = 8

func play_sfx(sound_name: String, volume_db: float = 0.0) -> AudioStreamPlayer:
	# Check if we're at the concurrent sound limit
	if sfx_players.size() >= max_concurrent_sounds:
		return null

	# Load the audio file
	var audio_path = "res://assets/audio/sfx/" + sound_name + ".ogg"
	var audio_stream = load(audio_path)

	# Handle missing audio files gracefully
	if audio_stream == null:
		push_error("Failed to load audio file: " + audio_path)
		return null

	# Create new AudioStreamPlayer
	var player = AudioStreamPlayer.new()
	player.stream = audio_stream
	player.volume_db = volume_db

	# Add to tree and play
	add_child(player)
	player.play()

	# Track player
	sfx_players.append(player)

	# Connect finished signal to cleanup
	player.finished.connect(func():
		sfx_players.erase(player)
		player.queue_free()
	)

	return player

func play_transformation_sound(type: String) -> AudioStreamPlayer:
	match type:
		"translate":
			return play_sfx("transform_blue")
		"rotate":
			return play_sfx("transform_gold")
		"scale":
			return play_sfx("transform_green")
		_:
			return null
