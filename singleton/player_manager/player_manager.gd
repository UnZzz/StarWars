extends Node

class_name PlayerManger

@export var _character_player_scene : PackedScene

var now_player : PlayerCharacter

func spawn_player_at(spawn_node : Node3D):
	if(now_player != null):
		now_player.queue_free()

	now_player = _character_player_scene.instantiate()
	spawn_node.add_child(now_player)
	pass
