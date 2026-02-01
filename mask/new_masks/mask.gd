extends Area3D
class_name Mask


@export var speed = 20
@export var life_time = 20

var atk : int = 0

@export
var id : String = "5"

var now_time
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	now_time = 20
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	now_time -= delta
	global_position += global_basis.x * speed * delta
	
	if(now_time <= 0):
		queue_free()
	pass
	
	
func _on_body_entered(body: Node3D) -> void:
	if(body is BaseStar):
		(body as BaseStar).hit_extended(atk, id)
		queue_free()
	pass # Replace with function body.
