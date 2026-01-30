extends Area3D

@export var next_map : PackedScene
@export var map_root : Map



func _on_body_entered(body: Node3D) -> void:
	if body is PlayerCharacter:
		_switch_the_map()
	pass # Replace with function body.

func _switch_the_map():
	map_root.emit_to_next_map(next_map)
	pass
