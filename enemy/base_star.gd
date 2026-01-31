extends CharacterBody3D

class_name BaseStar
var type = 1

@export var gravity : float = 0.98

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	velocity += Vector3.DOWN * gravity
	move_and_slide()
	for idx in range(0,get_slide_collision_count()):
		var collied_body = get_slide_collision(idx)
		var collider = collied_body.get_collider()
		if(collider is PlayerCharacter):
			PlayerManager.stop_player()
	pass

func hit(atk: int) -> void:
	print("atk: ", atk)
	if(abs(atk) < 30):
		queue_free()
	pass

func _exit_tree() -> void:
	WaveManager.current_enemy_count -= 1
	if WaveManager.current_enemy_count < 0:
		WaveManager.current_enemy_count = 0
