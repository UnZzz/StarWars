extends StaticBody3D


@export var up_length_m : float = 3
@export var speed_ratio : float = 0.05

var is_opened : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_opened:
		global_position.y = lerp(global_position.y, up_length_m, speed_ratio)
	else:
		global_position.y = lerp(global_position.y, 0.0, speed_ratio)
	pass
	
func open():
	is_opened = true
	pass
	
func close():
	is_opened = false
	pass
