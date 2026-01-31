extends Area3D
class_name SpawnArea

@onready
var timer : Timer = $Timer
@onready
var _on_screen_notifier : VisibleOnScreenNotifier3D = $VisibleOnScreenNotifier3D
@export var enemy_scenes : Array[PackedScene]
@export var generate_gap_time_sec : float = 1

func _ready() -> void:
	timer.wait_time = generate_gap_time_sec
	return

func _on_timer_timeout() -> void:
	if(!WaveManager.is_having_wave):
		return
	if(WaveManager.current_enemy_count >= WaveManager.now_max_enemy_count):
		return
	if(!_on_screen_notifier.is_on_screen()):
		if(get_overlapping_bodies().size() == 0):
			var new_enemy = enemy_scenes.pick_random().instantiate()
			add_child(new_enemy)
			WaveManager.current_enemy_count += 1
	return # Replace with function body.
