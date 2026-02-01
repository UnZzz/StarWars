extends Control

@onready var wave_number : Label = $MarginContainer/HBoxContainer/VBoxContainer2/WaveNumber
@onready var time_left : Label = $MarginContainer/HBoxContainer/VBoxContainer/TimeLeft

func _process(delta: float) -> void:
	wave_number.text = str(WaveManager.started_wave_count)
	time_left.text = str(WaveManager.time_left) + "s"
	pass
