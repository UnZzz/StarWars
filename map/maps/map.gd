extends Node

class_name Map

@export var player_start_point : PlayerStartPoint

signal to_next_map(map : PackedScene)
signal map_event_emitted(event_name : StringName)

func emit_to_next_map(map: PackedScene):
	emit_signal("to_next_map", map)
	
func emit_map_event_emitted(event_name : StringName):
	emit_signal("map_event_emitted", event_name)
