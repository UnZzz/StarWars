extends CharacterBody3D

class_name BaseStar
var type = 1
@onready var face_mesh : Node3D = $FaceNode
@onready var label : Label3D = $RotIndication
var _possible_angles : Array[int] = [0, 30, 60, 120, 180, 240, 300]
var current_angle : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_angle = _possible_angles.pick_random()
	face_mesh.set_rotation(Vector3(0, current_angle, 0))
	label.text = str(current_angle)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	move_and_slide()
	pass

func hit(atk: int) -> void:
	print("atk: ", atk)
	if(abs(atk - current_angle) == 0 or abs(atk - current_angle) == 180):
		print("match: ", current_angle)
		queue_free()
	else: print("not a match: ", current_angle)
	pass

func _exit_tree() -> void:
	SpawnArea.current_enemy_count -= 1
