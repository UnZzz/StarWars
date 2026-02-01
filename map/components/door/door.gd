extends StaticBody3D


@export var up_length_m : float = 10
@export var speed_ratio : float = 0.05

var is_opened : bool = false
var original_y_position : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	original_y_position = global_position.y
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_opened:
		global_position.y = lerp(global_position.y, original_y_position + up_length_m, speed_ratio)
	else:
		global_position.y = lerp(global_position.y, original_y_position , speed_ratio)
	pass
	
func open():
	is_opened = true
	pass
	
	
func close():
	is_opened = false
	pass
