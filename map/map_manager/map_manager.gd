extends Node
class_name MapManager

@export var init_map : PackedScene

var now_map : Map
signal map_event_emitted(event_name : StringName)

func switch_to(map : PackedScene):
	if(now_map != null):
		now_map.queue_free()
	
	now_map = map.instantiate()

	add_child(now_map)
	now_map.connect("to_next_map", _on_map_switch_emitted)
	PlayerManager.spawn_player_at(now_map.player_start_point)
	pass

func _ready() -> void:
	pass
	
func _on_map_switch_emitted(map : PackedScene):
	switch_to(map)
	pass
