extends Control

signal restart_pressed

func _on_button_pressed() -> void:
	emit_signal("restart_pressed")
	AudioManager.ui_restart.play()
	AudioManager.bg_music_map.stop()
	AudioManager.bg_music_lobby.play()
	pass
