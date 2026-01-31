extends Node3D

@onready var texture_rect : TextureRect = $TextureRect
@export var mask_scene : Array[PackedScene]

var _possible_angles : Array[int] = [0, 30, 60, 120, 180, 240, 300]
var _now_projectile : Projectile3D_extended

func _ready() -> void:
	_setup_new_projectile()
	return

func _physics_process(delta: float) -> void:
	if(Input.is_action_just_released("rotate_clockwise")):
		set_now_mask_rotation_degree(get_now_mask_rotation_degree() + 30)
	elif(Input.is_action_just_released("rotate_anti_clockwise")):
		set_now_mask_rotation_degree(get_now_mask_rotation_degree() - 30)
	if(Input.is_action_just_pressed("fire")):
		fire()
		AudioManager.plyr_gun_shoot.play()
	return
	
func fire() -> void:
	add_child(_now_projectile)
	_now_projectile.rotate_y(deg_to_rad(180))
	_now_projectile.top_level = true
	_setup_new_projectile()
	return

func set_now_mask_rotation_degree(degree: int) -> void:
	degree = posmod(degree, 360)
	print("degree: ",degree)
	_now_projectile.atk = degree
	texture_rect.rotation_degrees = degree
	return

func get_now_mask_rotation_degree() -> int:
	return _now_projectile.atk
	
func _setup_new_projectile() -> void:
	_now_projectile = mask_scene.pick_random().instantiate()
	set_now_mask_rotation_degree(_possible_angles.pick_random())
