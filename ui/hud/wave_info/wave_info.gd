extends Control

@onready var wave_number : Label = $MarginContainer/VBoxContainer/HBoxContainer/WaveNumber
@onready var enemy_count : Label = $MarginContainer/VBoxContainer/HBoxContainer2/EnemyCount
@onready var time_left : Label = $MarginContainer/VBoxContainer/HBoxContainer3/TimeLeft

func _process(delta: float) -> void:
	wave_number.text = str(WaveManager.started_wave_count)
	enemy_count.text = str(WaveManager.current_enemy_count)
	time_left.text = str(WaveManager.time_left) + "s"
	pass
