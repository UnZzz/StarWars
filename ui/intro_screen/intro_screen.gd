extends Control
class_name IntroScene

signal intro_play_finished

func _on_timer_timeout() -> void:
	emit_signal("intro_play_finished")
	pass # Replace with function body.

func play() -> void:
	pass
