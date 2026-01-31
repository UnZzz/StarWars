extends Node

@export var _character_player_scene : PackedScene

signal player_is_dead

var now_player : PlayerCharacter

func spawn_player_at(spawn_node : Node3D):
	if(now_player != null):
		now_player.queue_free()

	now_player = _character_player_scene.instantiate()
	spawn_node.add_child(now_player)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass
	
func stop_player():
	emit_signal("player_is_dead")
	now_player.process_mode = Node.PROCESS_MODE_DISABLED
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
