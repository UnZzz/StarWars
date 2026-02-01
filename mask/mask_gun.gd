extends Node3D

@onready var texture_rect : TextureRect = $TextureRect
@onready var star_mesh : MeshInstance3D = $gun/Hand/MeshInstance3D

@export var mask_scene : Array[PackedScene]
@export var fire_cooldown : float = 0.5

var _possible_angles : Array[int] = [0, 30, 60, 90, 120, 150, 180, 210, 240, 270, 300, 330]
var _now_projectile : Mask
var _can_fire : bool = true
var current_angle : int

func _ready() -> void:
	current_angle = 0
	_setup_new_projectile()
	return

func _physics_process(delta: float) -> void:
	if(Input.is_action_just_released("rotate_clockwise") or Input.is_action_just_pressed("rotate_clockwise_key")):
		current_angle += 30
		set_now_mask_rotation_degree(current_angle)
		AudioManager.plyr_gun_rotate.play()
	elif(Input.is_action_just_released("rotate_anti_clockwise") or Input.is_action_just_pressed("rotate_anti_clockwise_key")):
		current_angle -= 30
		set_now_mask_rotation_degree(current_angle)
		AudioManager.plyr_gun_rotate.play()
	if(Input.is_action_just_pressed("fire")):
		fire()
		AudioManager.plyr_gun_shoot.play()
	return
	
func fire() -> void:
	if not _can_fire:
		return
		
	_can_fire = false
	
	add_child(_now_projectile)
	_now_projectile.rotate_y(deg_to_rad(180))
	_now_projectile.top_level = true
	
	get_tree().create_timer(fire_cooldown).timeout.connect(_on_cooldown_finished)
	
	_setup_new_projectile()
	return

func _on_cooldown_finished() -> void:
	_can_fire = true

func set_now_mask_rotation_degree(degree: int) -> void:
	degree = posmod(degree, 360)
	print("degree: ",degree)
	_now_projectile.atk = degree
	texture_rect.rotation_degrees = degree
	star_mesh.rotation_degrees.z = degree
	return

func get_now_mask_rotation_degree() -> int:
	return _now_projectile.atk
	
	
var idx = 0

func _setup_new_projectile() -> void:
	_now_projectile = mask_scene[idx].instantiate()
	idx += 1
	idx = idx % mask_scene.size()
	var texture : Texture2D = _now_projectile.get_meta("texture")
	(star_mesh.material_override as StandardMaterial3D).albedo_texture = texture
	set_now_mask_rotation_degree(current_angle)
