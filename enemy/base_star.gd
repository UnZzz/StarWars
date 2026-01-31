extends CharacterBody3D

class_name BaseStar
var type = 1

@export var gravity : float = 0.98
@export var scary_distance : float = 5.0

@onready var scary_face : MeshInstance3D = $ScaryFace
@onready var happy_face : MeshInstance3D = $HappyFace

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scary_face.visible = false
	happy_face.visible = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_face_based_on_distance()

func update_face_based_on_distance() -> void:
	if PlayerManager and PlayerManager.now_player:
		var player = PlayerManager.now_player
		var player_pos = player.global_position
		var distance_to_player = global_position.distance_to(player_pos)
		
		if distance_to_player <= scary_distance:
			scary_face.visible = true
			happy_face.visible = false
		else:
			scary_face.visible = false
			happy_face.visible = true
	else:
		scary_face.visible = false
		happy_face.visible = true

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
	if(abs(current_face_angle - atk) % 180 == 0):
		queue_free()
	pass

func _exit_tree() -> void:
	WaveManager.current_enemy_count -= 1
	if WaveManager.current_enemy_count < 0:
		WaveManager.current_enemy_count = 0
