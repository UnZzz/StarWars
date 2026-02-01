extends CharacterBody3D

class_name BaseStar


var type = 1

@export var points : int = 5

@export var gravity : float = 0.98
@export var scary_distance : float = 5.0

@onready var scary_face : MeshInstance3D = $ScaryFace
@onready var happy_face : MeshInstance3D = $HappyFace
@onready var explosion_area : Area3D = $ProximityExplosion
@onready var is_shot : bool = false
@onready var star_body : MeshInstance3D = $StarBody
@onready var star_mask : MeshInstance3D = $StarMask
@onready var indicator : MeshInstance3D = $Indicator

@onready var navigation_agent : NavigationAgent3D = $NavigationAgent3D
var global_target_position : Vector3

var _possible_angles : Array[int] = [0, 30, 60, 90, 120, 150, 180, 210, 240, 270, 300]
var current_face_angle : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scary_face.visible = false
	happy_face.visible = true
	star_mask.visible = false
	add_to_group("enemies")
	current_face_angle = _possible_angles.pick_random()
	scary_face.set_instance_shader_parameter("rotation_angle", deg_to_rad(current_face_angle))
	happy_face.set_instance_shader_parameter("rotation_angle", deg_to_rad(current_face_angle))
	star_body.set_instance_shader_parameter("rotation_angle", deg_to_rad(current_face_angle))
	star_mask.set_instance_shader_parameter("rotation_angle", deg_to_rad(current_face_angle))
	indicator.set_instance_shader_parameter("rotation_angle", deg_to_rad(current_face_angle))

	
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


func hit_extended(atk: int, id: String) -> void:
	print("atk: ", atk)
	print("points:", id)
	if(id.to_int() != points):
		return
	is_shot = true
	if(abs(current_face_angle - atk) % 180 == 0):
		var other_exploded_stars = explosion_area.get_other_exploded_stars()
		for star in other_exploded_stars:
			if star.is_in_group("enemies") and star != self and !(star.is_shot):
				if star.has_method("hit"):
					star.death_persist() #this kills the neighbor 
		death_persist()
	pass
	
func death_persist():
	star_mask.visible = true
	process_mode = Node.PROCESS_MODE_DISABLED
	get_tree().create_timer(1.0).timeout.connect(remove)
	
func remove():
	WaveManager.now_total_score += 100
	queue_free()

func _exit_tree() -> void:
	WaveManager.current_enemy_count -= 1
	if WaveManager.current_enemy_count < 0:
		WaveManager.current_enemy_count = 0
