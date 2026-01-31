extends Control

signal restart_pressed

func _on_button_pressed() -> void:
	emit_signal("restart_pressed")
	pass
