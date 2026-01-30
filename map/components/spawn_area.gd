extends Area3D
class_name SpawnArea

static var current_enemy_count = 0
static var max_enemy_count = 30

@onready
var _on_screen_notifier : VisibleOnScreenNotifier3D = $VisibleOnScreenNotifier3D
@export var enemy_scenes : Array[PackedScene]

func _on_timer_timeout() -> void:
	if(current_enemy_count >= max_enemy_count):
		return
	if(!_on_screen_notifier.is_on_screen()):
		if(get_overlapping_bodies().size() == 0):
			var new_enemy = enemy_scenes.pick_random().instantiate()
			add_child(new_enemy)
			current_enemy_count += 1
	return # Replace with function body.
