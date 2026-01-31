extends Area3D

@export_file var next_map : String
@export var map_root : Map



func _on_body_entered(body: Node3D) -> void:
	if body is PlayerCharacter:
		_switch_the_map()
	pass # Replace with function body.

func _switch_the_map():
	var packed_scene = load(next_map) as PackedScene
	map_root.emit_to_next_map(packed_scene)
	pass
