extends CharacterBody3D

class_name BaseStar
var type = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	move_and_slide()
	pass

func hit(atk: int) -> void:
	print("atk: ", atk)
	if(abs(atk) < 30):
		queue_free()
	pass

func _exit_tree() -> void:
	SpawnArea.current_enemy_count -= 1
