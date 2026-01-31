extends Node

@export var mute: bool = false

var bg_music_player: AudioStreamPlayer
var current_music: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bg_music_player = AudioStreamPlayer.new()
	add_child(bg_music_player)
	bg_music_player.stream = load("res://assets/audio/music/塵沙_Music_V2.wav")
	bg_music_player.volume_db = -20.0
	PlayMusic()

func PlayMusic():
	if not mute:
		bg_music_player.play()
	
