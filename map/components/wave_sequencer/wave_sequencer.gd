extends Node

@export var wave_sequence : Array[Wave]
@export var one_shoot : bool = false

var now_wave_idx = 0

func _ready() -> void:
	WaveManager.wave_finished.connect(_on_wave_finished)
	_start_first_wave()
	print("hello size")

func _on_wave_finished():
		WaveManager.start_new_wave(wave_sequence[now_wave_idx])
		now_wave_idx+=1
		now_wave_idx = posmod(now_wave_idx, wave_sequence.size())

func _start_first_wave():
	WaveManager.start_new_wave(wave_sequence[0])
	now_wave_idx += 1
