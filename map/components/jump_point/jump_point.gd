extends Area3D
class_name JumpPoint

@export var paired_jump_point : JumpPoint

var moving_bodies : Array[BaseStar]


func _physics_process(delta: float) -> void:
	for i in moving_bodies:
		i.global_position = i.global_position.lerp(paired_jump_point.global_position ,0.1)
		if i.global_position.distance_to(paired_jump_point.global_position):
			moving_bodies.remove_at(moving_bodies.find(i))
			i.process_mode = PROCESS_MODE_INHERIT
			
func _on_body_entered(body: Node3D) -> void:
	if(body is BaseStar && !paired_jump_point.moving_bodies.has(body)):
		moving_bodies.append(body)
		body.process_mode = PROCESS_MODE_DISABLED
	pass # Replace with function body.
