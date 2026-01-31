extends Node3D

@onready
var map_manager : MapManager = $MapManager

func _ready() -> void:
	map_manager.switch_to(map_manager.init_map)
	pass
