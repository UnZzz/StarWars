extends Area3D
class_name JumpPoint

@export var paired_jump_point : JumpPoint

var moving_bodies : Array[BaseStar]

static var body_cd : Dictionary[BaseStar, float]


func _physics_process(delta: float) -> void:
	print(body_cd)
	
	for key in body_cd:
		var value = body_cd[key]
		body_cd[key] = value - delta
	
	for i in moving_bodies:
		i.global_position = i.global_position.lerp(paired_jump_point.global_position ,0.1)
		var distance = i.global_position.distance_to(paired_jump_point.global_position)
		if distance < 0.1:
			moving_bodies.remove_at(moving_bodies.find(i))
			i.process_mode = PROCESS_MODE_INHERIT
			body_cd.set(i, 10.)
			
func _on_body_entered(body: Node3D) -> void:
	#print("cd:",body_cd.get_or_add(body ,0.))
	if(body is BaseStar && body_cd.get_or_add(body ,0.) <= 0.):
		moving_bodies.append(body)
		body.process_mode = PROCESS_MODE_DISABLED
		body_cd[body as BaseStar] = 10.

	pass # Replace with function body.
