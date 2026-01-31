extends Node

@onready
var timer : Timer = $Timer

var started_wave_count : int = 0
var now_max_enemy_count : int = 10
var current_enemy_count : int = 0

var is_active : bool = false
var time_left : int = 0
var is_having_wave : bool = false

signal wave_finished

func start_new_wave(wave : Wave):
	is_having_wave = true
	started_wave_count += 1
	now_max_enemy_count = current_enemy_count + wave.max_enemy_count
	timer.wait_time = wave.wave_length_sec
	timer.start()
	pass


func clean_wave():
	started_wave_count = 0
	current_enemy_count = 0
	timer.stop()
	time_left = 0
	is_having_wave = false
	pass

func _on_timer_timeout() -> void:
	timer.stop()
	time_left = 0
	is_having_wave = false
	emit_signal("wave_finished")
	pass # Replace with function body.
	
func _process(delta: float) -> void:
	if is_having_wave:
		time_left = timer.time_left
